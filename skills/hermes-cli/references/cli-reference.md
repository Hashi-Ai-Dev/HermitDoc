# Hermes CLI Reference

Complete reference for all `hermes` commands.

## Global Flags

```
hermes [flags] [command]

  --version, -V             Show version
  -q, -z, --prompt TEXT   Single query (non-interactive)
  -m, --model MODEL        Model override (e.g. anthropic/claude-sonnet-4)
  --provider PROVIDER       Force provider (openrouter, anthropic, etc.)
  -t, --toolsets LIST      ComComma-separated toolsets
  --resume, -r SESSION     Resume session by ID or title
  --continue, -c [NAME]   Resume by name or most recent
  --worktree               Isolated git worktree mode
  --skills SKILL           Preload skills (comma-separated or repeat --skills for each)
  --profile, -p NAME      Use a named profile
  --yolo                   Skip dangerous command approval
  --pass-session-id        Include session ID in system prompt
  --ignore-user-config     Ignore ~/.hermes/config.yaml
  --ignore-rules           Ignore CLAUDE.md/.cursorrules
  --tui                    Start in TUI mode
  --dev                    Developer mode
  --accept-hooks           Auto-approve shell hooks
```

No subcommand defaults to `chat`.

## Chat

```
hermes chat [flags]
```

| Flag | Description |
|------|-------------|
| `-Q, --quiet` | Suppress banner and tool previews |
| `--checkpoints` | Enable filesystem snapshots (`/rollback`) |

## Configuration

```
hermes config {show,edit,set,path,env-path,check,migrate}
```

| Command | Description |
|---------|-------------|
| `hermes config show` | View current config |
| `hermes config edit` | Open config.yaml in $EDITOR |
| `hermes config set KEY VAL` | Set a config value |
| `hermes config path` | Print config.yaml path |
| `hermes config env-path` | Print .env path |
| `hermes config check` | Check for missing/outdated config |
| `hermes config migrate` | Update config with new options |

## Model & Providers

| Command | Description |
|---------|-------------|
| `hermes model` | Interactive model/provider picker |
| `hermes login [--provider PROVIDER]` | OAuth login (nous, openai-codex, qwen-oauth) |
| `hermes logout` | Clear stored auth |
| `hermes auth list [PROVIDER]` | List pooled credentials |
| `hermes auth remove PROVIDER INDEX` | Remove by provider + index |
| `hermes auth reset PROVIDER` | Clear exhaustion status |
| `hermes fallback` | Manage fallback providers |

## Skills

```
hermes skills {browse,search,install,inspect,list,check,update,audit,uninstall,reset,publish,snapshot,tap,config}
```

| Command | Description |
|---------|-------------|
| `hermes skills browse` | Browse all available skills (paginated) |
| `hermes skills search QUERY` | Search skill registries |
| `hermes skills install ID` | Install a skill (ID or https://…/SKILL.md URL) |
| `hermes skills inspect ID` | Preview without installing |
| `hermes skills list` | List installed skills |
| `hermes skills check` | Check installed hub skills for updates |
| `hermes skills update` | Update installed hub skills |
| `hermes skills audit` | Re-scan installed hub skills |
| `hermes skills uninstall NAME` | Remove a hub-installed skill |
| `hermes skills reset NAME` | Reset a bundled skill |
| `hermes skills publish PATH` | Publish a skill to a registry |
| `hermes skills snapshot` | Export/import skill configurations |
| `hermes skills tap add REPO` | Add a GitHub repo as skill source |
| `hermes skills config` | Interactive enable/disable per platform |

## Tools

```
hermes tools [{list,disable,enable}] [TOOL...]
```

| Command | Description |
|---------|-------------|
| `hermes tools list` | Show all tools and their enabled/disabled status |
| `hermes tools list --summary` | Print summary of enabled tools per platform |
| `hermes tools disable TOOL` | Disable a toolset or MCP tool |
| `hermes tools enable TOOL` | Enable a toolset or MCP tool |

**Built-in toolsets:** `web`, `browser`, `terminal`, `file`, `code_execution`, `vision`, `image_gen`, `tts`, `skills`, `todo`, `memory`, `session_search`, `clarify`, `delegation`, `cronjob`, `messaging`, `rl`, `homeassistant`, `moa`

## Cron Jobs

```
hermes cron {list,create,add,edit,pause,resume,run,remove,rm,delete,status,tick}
```

| Command | Description |
|---------|-------------|
| `hermes cron list` | List scheduled jobs |
| `hermes cron create SCHED [PROMPT]` | Create a scheduled job |
| `hermes cron edit ID` | Edit schedule, prompt, delivery |
| `hermes cron pause ID` | Pause a job |
| `hermes cron resume ID` | Resume a paused job |
| `hermes cron run ID` | Run on next scheduler tick |
| `hermes cron remove ID` | Delete a job |
| `hermes cron status` | Check if cron scheduler is running |
| `hermes cron tick` | Run due jobs once and exit |

**Schedule formats:** `30m`, `every 2h`, `0 9 * * *` (cron syntax)

## Gateway (Messaging Platforms)

```
hermes gateway {run,start,stop,restart,status,install,uninstall,setup,migrate-legacy}
```

| Command | Description |
|---------|-------------|
| `hermes gateway run` | Run in foreground (recommended for WSL, Docker, Termux) |
| `hermes gateway start` | Start systemd/launchd service |
| `hermes gateway stop` | Stop service |
| `hermes gateway restart` | Restart service |
| `hermes gateway status` | Show gateway status |
| `hermes gateway install` | Install as systemd/launchd service |
| `hermes gateway uninstall` | Uninstall service |
| `hermes gateway setup` | Configure messaging platforms |
| `hermes gateway migrate-legacy` | Remove legacy hermes.service units |

## Pairing

```
hermes pairing {list,approve,revoke,clear-pending}
```

| Command | Description |
|---------|-------------|
| `hermes pairing list` | Show pending + approved users |
| `hermes pairing approve CODE` | Approve a pairing code |
| `hermes pairing revoke USER_ID` | Revoke user access |
| `hermes pairing clear-pending` | Clear all pending codes |

## Sessions

```
hermes sessions [list,resume,export,rename,delete,prune,stats]
```

| Command | Description |
|---------|-------------|
| `hermes sessions list` | List recent sessions |
| `hermes sessions resume SESSION` | Resume a session |
| `hermes sessions export OUT` | Export to JSONL |
| `hermes sessions rename ID TITLE` | Rename a session |
| `hermes sessions delete ID` | Delete a session |
| `hermes sessions prune --older-than DAYS` | Clean up old sessions |
| `hermes sessions stats` | Session store statistics |

## MCP Servers

```
hermes mcp {serve,add,remove,rm,list,ls,test,configure,config,login}
```

| Command | Description |
|---------|-------------|
| `hermes mcp serve` | Run Hermes as an MCP server |
| `hermes mcp add NAME [OPTIONS]` | Add an MCP server |
| `hermes mcp remove NAME` | Remove an MCP server |
| `hermes mcp list` | List configured MCP servers |
| `hermes mcp test NAME` | Test MCP server connection |
| `hermes mcp configure NAME` | Toggle tool selection for a server |
| `hermes mcp login NAME` | Force re-authentication for OAuth-based servers |

**MCP add options:**
- `--url URL` — HTTP/SSE endpoint URL
- `--command COMMAND` — Stdio command (e.g. npx, python)
- `--args [ARGS ...]` — Arguments for stdio command
- `--auth {oauth,header}` — Auth method
- `--preset PRESET` — Known MCP preset name
- `--env KEY=VALUE` — Environment variables for stdio servers

## Webhooks

| Command | Description |
|---------|-------------|
| `hermes webhook subscribe NAME` | Create route at /webhooks/<name> |
| `hermes webhook list` | List subscriptions |
| `hermes webhook remove NAME` | Remove a subscription |

## Hooks

```
hermes hooks {list,ls,test,revoke,remove,rm,doctor}
```

| Command | Description |
|---------|-------------|
| `hermes hooks list` | List configured hooks with matcher, timeout, consent status |
| `hermes hooks test EVENT` | Fire every hook matching EVENT against a synthetic payload |
| `hermes hooks revoke COMMAND` | Remove a command's allowlist entries |
| `hermes hooks doctor` | Check each hook: exec bit, allowlist, mtime drift, JSON validity, timing |

## Logs

```
hermes logs [LOG_NAME] [options]
```

| Command | Description |
|---------|-------------|
| `hermes logs` | Show last 50 lines of agent.log |
| `hermes logs errors` | Show last 50 lines of errors.log |
| `hermes logs gateway` | Show last 50 lines of gateway.log |
| `hermes logs list` | List available log files with sizes |
| `hermes logs -n LINES` | Number of lines to show (default: 50) |
| `hermes logs -f` | Follow in real time (like tail -f) |
| `hermes logs --level LEVEL` | Minimum level: DEBUG, INFO, WARNING, ERROR |
| `hermes logs --session ID` | Filter by session ID substring |
| `hermes logs --since TIME` | Since TIME ago (e.g. 1h, 30m, 2d) |
| `hermes logs --component NAME` | Filter by component: gateway, agent, tools, cli, cron |

## Memory

```
hermes memory {setup,status,off,reset}
```

| Command | Description |
|---------|-------------|
| `hermes memory setup` | Interactive provider selection and configuration |
| `hermes memory status` | Show current memory provider config |
| `hermes memory off` | Disable external provider (built-in only) |
| `hermes memory reset` | Erase all built-in memory (MEMORY.md and USER.md) |

**Available providers:** honcho, openviking, mem0, hindsight, holographic, retaindb, byterover, supermemory

Note: Built-in memory (MEMORY.md/USER.md) is always active regardless of external provider.

## Other Commands

| Command | Description |
|---------|-------------|
| `hermes doctor [--fix] [--deep]` | Check configuration and dependencies |
| `hermes status [--all]` | Show component status |
| `hermes dump` | Dump setup summary for support/debugging |
| `hermes debug` | Debug tools — upload logs and system info |
| `hermes backup` | Back up Hermes home directory to a zip file |
| `hermes import FILE` | Restore a Hermes backup from a zip file |
| `hermes version` | Show Hermes version |
| `hermes update` | Update to latest version |
| `hermes uninstall` | Uninstall Hermes |
| `hermes completion bash\|zsh` | Shell completions |
| `hermes acp` | ACP server (IDE integration) |
| `hermes claw migrate` | Migrate from OpenClaw |
| `hermes profile {list,create,use,delete,show,alias,rename,export,import}` | Profile management |
| `hermes plugins {install,update,remove,rm,uninstall,list,ls,enable,disable}` | Plugin management |
| `hermes kanban` | Multi-profile collaboration board |
| `hermes insights [--days N] [--source SOURCE]` | Token usage, costs, tool patterns |
| `hermes curator {status,run}` | Background skill maintenance |
| `hermes dashboard` | Start the web dashboard |