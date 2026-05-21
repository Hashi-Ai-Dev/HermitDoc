---
name: hermes-mcp
description: "Use when setting up MCP servers or connecting tools. Covers: hermes mcp CLI (serve, add, remove, list, test, configure, login), HTTP/SSE and stdio transports, MCP presets, auth methods (oauth, header), env vars for stdio servers. Triggers on: MCP, model context protocol, mcp server, stdio, http, mcp tools."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [MCP, model-context-protocol, mcp-server, stdio, http, integration]
    related_skills: [hermes-config, hermes-tools, hermes-cli]
    hermes_version: "v2026.5.16"
---

# Hermes MCP Reference

MCP (Model Context Protocol) integration — connecting external tools and running Hermes as an MCP server.

## MCP CLI

```bash
hermes mcp serve               # Run Hermes as MCP server (expose conversations to other agents)
hermes mcp list                # List configured MCP servers
hermes mcp add NAME [OPTIONS]  # Add an MCP server
hermes mcp remove NAME         # Remove an MCP server
hermes mcp test NAME           # Test connection
hermes mcp configure NAME      # Toggle tool selection for a server
hermes mcp login NAME          # Force re-auth for OAuth-based servers
```

### Adding a Server

**HTTP/SSE endpoint:**
```bash
hermes mcp add my-api --url "https://api.example.com/mcp"
```

**Stdio command:**
```bash
hermes mcp add github --command "npx @modelcontextprotocol/server-github"
```

**With environment variables:**
```bash
hermes mcp add db --command "python /path/to/mcp-server.py" --env DB_HOST=localhost --env DB_PORT=5432
```

**With auth:**
```bash
hermes mcp add my-api --url "https://api.example.com/mcp" --auth header
hermes mcp add github --command "npx @modelcontextprotocol/server-github" --auth oauth
```

**With preset:**
```bash
hermes mcp add github --preset github
```

**With args:**
```bash
hermes mcp add filesystem --command "npx @anthropic/mcp-server-filesystem" --args "/path/to/serve"
```

### Removing a Server

```bash
hermes mcp remove my-api
hermes mcp rm my-api  # alias
```

### Testing

```bash
hermes mcp test github
hermes mcp test my-api
```

### Tool Selection

```bash
hermes mcp configure github
# Interactive picker — enable/disable specific tools from the server
```

## Running Hermes as MCP Server

```bash
hermes mcp serve
# Exposes Hermes tools via MCP protocol
# Other agents (Claude Code, etc.) can connect and use Hermes tools
```

## MCP Tools in Delegation

MCP tools are available via `server:tool` notation:

```python
delegate_task(
  goal="Create a GitHub issue",
  context="...",
  toolsets=["github:create_issue", "github:list_repos"]
)
```

## Common MCP Servers

### GitHub
```bash
hermes mcp add github --preset github
# Requires: GITHUB_TOKEN in .env
```

### File System
```bash
hermes mcp add filesystem --command "npx @anthropic/mcp-server-filesystem" --args "/workspace"
```

### Brave Search
```bash
hermes mcp add brave-search --command "npx @modelcontextprotocol/server-brave-search"
# Requires: BRAVE_API_KEY in .env
```

### Slack
```bash
hermes mcp add slack --preset slack
# Requires: SLACK_BOT_TOKEN in .env
```

## Security Notes

- Only add trusted MCP servers — they get tool access
- Review tool permissions before enabling
- Use `--env` for credentials, not hardcoded values

## References

- `hermes-config/` — MCP config keys
- `hermes-tools/` — tool reference
- `hermes-cli/` — MCP CLI commands
