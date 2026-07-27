#!/usr/bin/env bash
#
# Guards the two rot-prone facts the AgentBase browser packs depend on: the MCP
# endpoint host and its OAuth auth model. Real drift here is rare (~1 event/year)
# but silent and total — the server moves or changes auth under a still repo, and
# every packaged connector URL / skill instruction breaks at once. This asserts
# the live server still matches what the manifests and skills ship, and that the
# manifests haven't regressed to a static-token auth model.
#
# Exits non-zero with a "DRIFT: ..." line on any mismatch. Needs curl + jq.
set -euo pipefail

# The single canonical MCP URL the manifests and skills quote. If the server
# moves, this constant and the shipped strings must both change together.
CANONICAL_URL="https://api.agentbase.dk/mcp"
# RFC 9728 Protected Resource Metadata for /mcp — root-mounted, unauthenticated.
WELL_KNOWN="https://api.agentbase.dk/.well-known/oauth-protected-resource/mcp"
# Dead host from an earlier era; must never reappear in the repo.
STALE_HOST="api.flows.syv.ai"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PRM="$(mktemp)"
trap 'rm -f "$PRM"' EXIT

fail() { echo "DRIFT: $*" >&2; exit 1; }

echo "→ Fetching $WELL_KNOWN"
http_code="$(curl -sS -m 25 -o "$PRM" -w '%{http_code}' "$WELL_KNOWN")" \
  || fail "could not reach $WELL_KNOWN — host down, moved, or DNS gone"
[ "$http_code" = "200" ] || fail "well-known returned HTTP $http_code (expected 200)"
jq -e . "$PRM" >/dev/null 2>&1 || fail "well-known response is not valid JSON"

# The server must still advertise /mcp at exactly the URL we ship.
resource="$(jq -r '.resource // empty' "$PRM")"
[ "$resource" = "$CANONICAL_URL" ] \
  || fail "advertised resource '$resource' != expected '$CANONICAL_URL' — endpoint moved"

# OAuth must still be the auth model (RFC 9728 lists the authorization server(s)).
authz_count="$(jq '(.authorization_servers // []) | length' "$PRM")"
[ "$authz_count" -ge 1 ] \
  || fail "no authorization_servers advertised — OAuth no longer offered at $CANONICAL_URL"

# The canonical URL must actually be what the repo ships (catches a stale constant
# above, or a manifest/skill that silently changed the URL).
grep -rqF "$CANONICAL_URL" "$REPO_ROOT" --include='*.json' --include='*.md' \
  --exclude-dir=.git \
  || fail "canonical URL $CANONICAL_URL is not present in any manifest or skill"

# Per-manifest checks. The endpoint host and auth model can only really regress in
# a plugin.json — skill prose may legitimately NAME the dead host as forbidden, so
# scanning it repo-wide would false-positive. Two things a manifest must never do:
#   1. point at the dead host, or
#   2. carry a static-token auth block — OAuth is tokenless, so a userConfig prompt
#      or an injected Authorization/headers block means we regressed to the old
#      bearer-token model. (The server's own bearer_methods_supported is a normal
#      OAuth field and is NOT checked here — only our manifests are.)
manifests=()
while IFS= read -r m; do manifests+=("$m"); done \
  < <(find "$REPO_ROOT" -path '*/.claude-plugin/plugin.json' -not -path '*/.git/*')
for m in "${manifests[@]}"; do
  if grep -qF "$STALE_HOST" "$m"; then
    fail "$m points at the dead host '$STALE_HOST' — use $CANONICAL_URL"
  fi
  if grep -qE '"(userConfig|headers|Authorization)"|Bearer ' "$m"; then
    fail "$m carries a token-auth block (userConfig/headers/Authorization/Bearer) — should be OAuth-only"
  fi
done

echo "OK: MCP connection contract intact."
echo "    resource            = $resource"
echo "    authorization_servers = $authz_count advertised"
echo "    manifests checked     = ${#manifests[@]} (no token-auth drift)"
