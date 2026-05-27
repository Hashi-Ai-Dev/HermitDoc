# In-Session Slash Commands

Complete reference for all `/` commands available during chat sessions.

## Session Control

| Command | Description |
|---------|-------------|
| `/new, /reset` | Fresh session (reloads skills) |
| `/clear` | Clear screen + new session |
| `/retry` | Resend last message |
| `/undo` | Remove last exchange |
| `/title [name]` | Name the session |
| `/compress` | Manually compress context |
| `/stop` | Kill background processes |
| `/rollback [N]` | Restore filesystem checkpoint |
| `/background <prompt>` | Run prompt in background |
| `/queue <prompt>` | Queue for next turn |
| `/resume [name]` | Resume a named session |

## Configuration

| Command | Description |
|---------|-------------|
| `/config` | Show config |
| `/model [name]` | Show or change model |
| `/reasoning [level]` | Set reasoning (none\|minimal\|low\|medium\|high\|xhigh\|show\|hide) |
| `/verbose` | Cycle: off → new → all → verbose |
| `/yolo` | Toggle approval bypass |

## Gateway

| Command | Description |
|---------|-------------|
| `/approve` | Approve pending command (gateway) |
| `/deny` | Deny pending command |
| `/restart` | Restart gateway |
| `/sethome` | Set current chat as home channel |
| `/update` | Update Hermes to latest |

## Tools & Skills

| Command | Description |
|---------|-------------|
| `/tools` | Manage tools (interactive) |
| `/toolsets` | List toolsets (CLI) |
| `/skills` | Search/install skills (CLI) |
| `/skill <name>` | Load a skill into session |
| `/cron` | Manage cron jobs (interactive) |
| `/reload-mcp` | Reload MCP servers |
| `/plugins` | List plugins |

## Utility

| Command | Description |
|---------|-------------|
| `/branch (/fork)` | Branch current session |
| `/browser` | Open CDP browser connection |
| `/history` | Show conversation history |
| `/save` | Save conversation to file |
| `/paste` | Attach clipboard image |
| `/image` | Attach local image file |

## Info

| Command | Description |
|---------|-------------|
| `/help` | Show commands |
| `/commands [page]` | Browse all commands |
| `/usage` | Token usage |
| `/insights [days]` | Usage analytics |
| `/status` | Session info |
| `/profile` | Active profile info |
| `/quit (/exit,/q)` | Exit CLI |