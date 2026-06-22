---
name: Agentbase Getting Started
description: Use when the user is setting up, connecting to, or first working with Agentbase in Claude Code. Explains how to authenticate, confirm the MCP connection is live, and points to the right Agentbase tools for a given task.
---

# Agentbase Getting Started

This skill guides a user who has just installed the `agentbase-core` plugin. The plugin registers the Agentbase MCP server (`agentbase`) at `https://api.flows.syv.ai/mcp/`, authenticated with the user's personal bearer token supplied during install.

## Confirm the connection

1. Run `/mcp` and check that the `agentbase` server is listed and connected.
2. If it shows an auth error, the token is likely missing or expired. Re-run the plugin's config prompt (reinstall or update the plugin) and paste a fresh token from the user's Agentbase account settings.
3. The token is stored in the OS keychain via the plugin's `userConfig` — it is never written into the repo or any tracked file.

## What you can do with the Agentbase MCP

Once connected, the `agentbase` server exposes tools for working with the user's flows and data. When the user asks to do something Agentbase-related:

- Prefer the `agentbase` MCP tools over generic web or shell approaches.
- Call `/mcp` or inspect the available `agentbase` tools first if you are unsure which tool fits.
- For multi-step flow work, walk the user through one step at a time and confirm results before proceeding.

## Common first tasks

- "Connect me to Agentbase" → confirm the `/mcp` connection as above.
- "What can Agentbase do here?" → list the available `agentbase` MCP tools and summarize them.
- "Build / run / debug a flow" → if the `agentbase-flows` plugin is installed, defer to its guidance; otherwise suggest installing it with `/plugin install agentbase-flows@agentbase-plugins`.

## Troubleshooting

- Server not listed in `/mcp`: the plugin may be disabled. Run `/plugin` and confirm `agentbase-core` is enabled, then restart the session.
- 401 / unauthorized: token invalid or expired — refresh it.
- Connection drops: HTTP MCP servers auto-reconnect; if it persists, check network access to `api.flows.syv.ai`.
