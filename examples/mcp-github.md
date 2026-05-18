---
name: example-mcp-github
description: "GitHub MCP server integration for Hermes"
version: 1.0.0
author: HermitDoc
---

# GitHub MCP Integration

Connect GitHub as an MCP server to access repo tools natively.

## Prerequisites

1. GitHub Personal Access Token with appropriate scopes
2. Node.js for running the MCP server

## Configuration

### 1. Add GitHub Token

```bash
# ~/.hermes/.env
GITHUB_TOKEN=ghp_your_token_here
```

### 2. Add MCP Server

```bash
hermes mcp add github --command "npx @modelcontextprotocol/server-github"
```

### 3. Configure

```yaml
# config.yaml
mcpServers:
  github:
    command: "npx"
    args: ["@modelcontextprotocol/server-github"]
    env:
      GITHUB_TOKEN: "${GITHUB_TOKEN}"
    enabled: true
```

## Testing

```bash
hermes mcp list              # see connected servers
hermes mcp test github       # test connection

# Restart to load new MCP tools
/reset
```

## Available Tools

GitHub MCP server provides:
- `github_list_repos` — list user repos
- `github_search_code` — search across repos
- `github_create_issue` — create issue
- `github_get_issue` — get issue details
- And more...

## Security

- Only use tokens with minimum required scopes
- Don't commit tokens to version control
- Review MCP tool permissions before enabling