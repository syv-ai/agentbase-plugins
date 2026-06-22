# agentbase-plugins

A public Claude Code plugin marketplace for Agentbase (https://syv.ai). It bundles the Agentbase MCP connection and opt-in guidance skills, so users install with a couple of slash commands instead of copy-pasting a raw `claude mcp add` line.

## Install (end users)

In a Claude Code session:

    /plugin marketplace add syv-ai/agentbase-plugins
    /plugin install agentbase-core@agentbase-plugins

During install you'll be prompted for your Agentbase API token. It's stored in your OS keychain — never in any file or repo.

Optional extra skill:

    /plugin install agentbase-flows@agentbase-plugins

After installing, run `/mcp` to confirm the `agentbase` server is connected.

## What's in here

- `agentbase-core` — registers the Agentbase MCP server and ships a getting-started skill. Install this first. Prompts for a token at install.
- `agentbase-flows` — opt-in guidance skill for building/debugging flows. Uses the connection from agentbase-core. No token.

Users pick a la carte — add more skill plugins to the marketplace over time and users install only what they want.

## Adding a new skill

1. Create `agentbase-<name>/.claude-plugin/plugin.json` (skill-only plugins need no `mcpServers` block).
2. Add `agentbase-<name>/skills/<name>/SKILL.md` with `name` and `description` frontmatter.
3. Append an entry to `plugins` in `.claude-plugin/marketplace.json`.

## Auth notes

The token is delivered via the plugin's `userConfig` (`apiToken`, `sensitive: true`) and injected into the MCP `Authorization` header as `Bearer ${user_config.apiToken}`. Because it's per-user and prompted at install, no secret is ever committed — which is why this repo is safe to keep public.

If/when the Agentbase MCP server supports OAuth 2.0, you can drop the `userConfig` token entirely and let Claude Code run the browser auth flow on first connect (`/mcp`).
