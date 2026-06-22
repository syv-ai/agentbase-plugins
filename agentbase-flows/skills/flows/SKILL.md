---
name: Agentbase Flows
description: Use when the user wants to build, run, edit, or debug an Agentbase flow. Provides the workflow conventions and the order of Agentbase MCP tool calls to use.
---

# Agentbase Flows

This skill helps the user work with Agentbase flows through the `agentbase` MCP server (provided by the `agentbase-core` plugin). If `/mcp` does not show `agentbase` connected, fix that first using the Agentbase Getting Started skill.

## Workflow

Replace the steps below with your real flow conventions before publishing — this is a starter template.

1. Clarify the goal of the flow before touching any tools.
2. Use the `agentbase` MCP tools to inspect existing flows so you do not duplicate work.
3. Make one change at a time and confirm the result with the user.
4. When running a flow, surface the output and any errors plainly.

## Conventions

- Document any flow-specific naming, triggers, or environment assumptions here.
- Note which `agentbase` tools correspond to create / read / update / run operations.

## Debugging

- Capture the exact error from the tool response and explain it in plain language.
- Suggest the smallest next step rather than rewriting an entire flow.
