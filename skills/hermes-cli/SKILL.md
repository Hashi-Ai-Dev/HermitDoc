---
name: hermes-cli
description: "Use when looking up Hermes CLI commands, flags, or interactive features. Complete CLI reference for ALL real hermes commands: chat, config, skills, sessions, cron, gateway, model, auth, profile, doctor, update, webhook, pairing, plugins, tools, mcp, hooks, logs, insights, backup, import. Triggers on: CLI, command, hermes, terminal, flags, help."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [CLI, commands, hermes, terminal, reference, slash-commands]
    related_skills: [hermes-config, hermes-tools]
    hermes_version: "v2026.5.16"
---

# Hermes CLI Reference

Complete verified reference for all `hermes` commands. Every command in this skill has been verified against the actual Hermes CLI.

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

Interact with Hermes in a chat session. Uses all global flags plus:
- `-Q, --quiet` — suppress banner and tool previews
- `--checkpoints` — enable filesystem snapshots (`/rollback`)

## Configuration

```
hermes config {show,edit,set,path,env-path,check,migrate}

hermes config show          View current config
hermes config edit         Open config.yaml in $EDITOR
hermes config set KEY VAL   Set a config value (e.g. hermes config set model.provider openrouter)
hermes config path         Print config.yaml path
hermes config env-path     Print .env path
hermes config check        Check for missing/outdated config
hermes config migrate      Update config with new options
```

## Model & Providers

```
hermes model                        Interactive model/provider picker
hermes login [--provider PROVIDER]  OAuth login (nous, openai-codex, qwen-oauth)
hermes logout                       Clear stored auth
hermes auth list [PROVIDER]        List pooled credentials
hermes auth remove PROVIDER INDEX   Remove by provider + index
hermes auth reset PROVIDER         Clear exhaustion status

hermes fallback                     Manage fallback providers (tried when primary fails)
```

## Skills

```
hermes skills {browse,search,install,inspect,list,check,update,audit,uninstall,reset,publish,snapshot,tap,config}

hermes skills browse              Browse all available skills (paginated)
hermes skills search QUERY       Search skill registries
hermes skills install ID         Install a skill (ID or https://…/SKILL.md URL)
hermes skills inspect ID         Preview without installing
hermes skills list               List installed skills
hermes skills check              Check installed hub skills for updates
hermes skills update             Update installed hub skills
hermes skills audit              Re-scan installed hub skills
hermes skills uninstall NAME     Remove a hub-installed skill
hermes skills reset NAME         Reset a bundled skill (clears user-modified tracking)
hermes skills publish PATH       Publish a skill to a registry
hermes skills snapshot           Export/import skill configurations
hermes skills tap add REPO       Add a GitHub repo as skill source
hermes skills config             Interactive enable/disable per platform
```

## Tools

```
hermes tools [{list,disable,enable}] [TOOL...]

hermes tools list              Show all tools and their enabled/disabled status
hermes tools list --summary   Print summary of enabled tools per platform
hermes tools disable TOOL      Disable a toolset or MCP tool (e.g. web, browser)
hermes tools enable TOOL       Enable a toolset or MCP tool
```

Built-in toolsets: `web`, `browser`, `terminal`, `file`, `code_execution`, `vision`, `image_gen`, `tts`, `skills`, `todo`, `memory`, `session_search`, `clarify`, `delegation`, `cronjob`, `messaging`, `rl`, `homeassistant`, `moa`

## Cron Jobs

```
hermes cron {list,create,add,edit,pause,resume,run,remove,rm,delete,status,tick}

hermes cron list               List scheduled jobs
hermes cron create SCHED [PROMPT]  Create a scheduled job
  --name NAME                  Human-friendly job name
  --deliver TARGET             Delivery: origin, local, telegram, discord, signal, or platform:chat_id
  --repeat N                   Optional repeat count
  --skill SKILL               Attach a skill (repeat for multiple)
  --script PATH                Python script whose stdout is injected into prompt each run
  --workdir PATH               Absolute path; injects AGENTS.md/CLAUDE.md/.cursorrules from that dir
hermes cron edit ID            Edit schedule, prompt, delivery
hermes cron pause ID           Pause a job
hermes cron resume ID          Resume a paused job
hermes cron run ID             Run on next scheduler tick
hermes cron remove ID          Delete a job
hermes cron status             Check if cron scheduler is running
hermes cron tick               Run due jobs once and exit
```

Schedule formats: `30m`, `every 2h`, `0 9 * * *` (cron syntax)

## Gateway (Messaging Platforms)

```
hermes gateway {run,start,stop,restart,status,install,uninstall,setup,migrate-legacy}

hermes gateway run             Run in foreground (recommended for WSL, Docker, Termux)
hermes gateway start           Start systemd/launchd service
hermes gateway stop            Stop service
hermes gateway restart         Restart service
hermes gateway status          Show gateway status
hermes gateway install         Install as systemd/launchd service
hermes gateway uninstall       Uninstall service
hermes gateway setup           Configure messaging platforms
hermes gateway migrate-legacy  Remove legacy hermes.service units from pre-rename installs
```

## Channels

Channel-specific subcommands (platform modules):
```
hermes channels                    # No such command — channel setup is via gateway setup or config
hermes whatsapp                   Set up WhatsApp integration
hermes slack                      Slack integration helpers (manifest generation, etc.)
```

## Pairing

```
hermes pairing {list,approve,revoke,clear-pending}

hermes pairing list               Show pending + approved users
hermes pairing approve CODE       Approve a pairing code
hermes pairing revoke USER_ID     Revoke user access
hermes pairing clear-pending     Clear all pending codes
```

## Sessions

```
hermes sessions [list,resume,export,rename,delete,prune,stats]

hermes sessions list             List recent sessions
hermes sessions resume SESSION   Resume a session
hermes sessions export OUT       Export to JSONL
hermes sessions rename ID TITLE  Rename a session
hermes sessions delete ID         Delete a session
hermes sessions prune --older-than DAYS  Clean up old sessions
hermes sessions stats            Session store statistics
```

## MCP Servers

```
hermes mcp {serve,add,remove,rm,list,ls,test,configure,config,login}

hermes mcp serve               Run Hermes as an MCP server (expose conversations to other agents)
hermes mcp add NAME [OPTIONS]  Add an MCP server
  --url URL                    HTTP/SSE endpoint URL
  --command COMMAND            Stdio command (e.g. npx, python)
  --args [ARGS ...]           Arguments for stdio command
  --auth {oauth,header}       Auth method
  --preset PRESET             Known MCP preset name
  --env KEY=VALUE             Environment variables for stdio servers
hermes mcp remove NAME         Remove an MCP server
hermes mcp list                List configured MCP servers
hermes mcp test NAME           Test MCP server connection
hermes mcp configure NAME      Toggle tool selection for a server
hermes mcp login NAME          Force re-authentication for OAuth-based servers
```

## Webhooks

```
hermes webhook subscribe NAME   Create route at /webhooks/<name>
hermes webhook list              List subscriptions
hermes webhook remove NAME      Remove a subscription
```

## Hooks

```
hermes hooks {list,ls,test,revoke,remove,rm,doctor}

hermes hooks list               List configured hooks with matcher, timeout, consent status
hermes hooks test EVENT         Fire every hook matching EVENT against a synthetic payload
hermes hooks revoke COMMAND     Remove a command's allowlist entries
hermes hooks doctor             Check each hook: exec bit, allowlist, mtime drift, JSON validity, timing
```

## Logs

```
hermes logs [LOG_NAME] [options]

hermes logs                     Show last 50 lines of agent.log
hermes logs errors             Show last 50 lines of errors.log
hermes logs gateway            Show last 50 lines of gateway.log
hermes logs list               List available log files with sizes
hermes logs -n LINES           Number of lines to show (default: 50)
hermes logs -f                 Follow in real time (like tail -f)
hermes logs --level LEVEL      Minimum level: DEBUG, INFO, WARNING, ERROR
hermes logs --session ID       Filter by session ID substring
hermes logs --since TIME       Since TIME ago (e.g. 1h, 30m, 2d)
hermes logs --component NAME   Filter by component: gateway, agent, tools, cli, cron
```

## Memory

```
hermes memory {setup,status,off,reset}

hermes memory setup             Interactive provider selection and configuration
hermes memory status            Show current memory provider config
hermes memory off               Disable external provider (built-in only)
hermes memory reset             Erase all built-in memory (MEMORY.md and USER.md)

Available providers: honcho, openviking, mem0, hindsight, holographic, retaindb, byterover, supermemory
Note: Built-in memory (MEMORY.md/USER.md) is always active regardless of external provider.
```

## Other Commands

```
hermes doctor [--fix] [--deep]  Check configuration and dependencies
hermes status [--all]           Show component status
hermes dump                     Dump setup summary for support/debugging
hermes debug                    Debug tools — upload logs and system info for support
hermes backup                   Back up Hermes home directory to a zip file
hermes import FILE              Restore a Hermes backup from a zip file
hermes version                  Show Hermes version
hermes update                   Update to latest version
hermes uninstall                Uninstall Hermes
hermes completion bash|zsh     Shell completions
hermes acp                     ACP server (IDE integration)
hermes claw migrate             Migrate from OpenClaw
hermes profile {list,create,use,delete,show,alias,rename,export,import}  Profile management
hermes plugins {install,update,remove,rm,uninstall,list,ls,enable,disable}  Plugin management
hermes kanban                  Multi-profile collaboration board
hermes insights [--days N] [--source SOURCE]  Token usage, costs, tool patterns
hermes curator {status,run}    Background skill maintenance
hermes dashboard               Start the web dashboard
```

## In-Session Slash Commands

### Session Control
```
/new, /reset       Fresh session (reloads skills)
/clear             Clear screen + new session
/retry             Resend last message
/undo              Remove last exchange
/title [name]      Name the session
/compress          Manually compress context
/stop              Kill background processes
/rollback [N]      Restore filesystem checkpoint
/background <prompt>  Run prompt in background
/queue <prompt>    Queue for next turn
/resume [name]     Resume a named session
```

### Configuration
```
/config            Show config
/model [name]     Show or change model
/reasoning [level] Set reasoning (none|minimal|low|medium|high|xhigh|show|hide)
/verbose           Cycle: off → new → all → verbose
/yolo              Toggle approval bypass
```

### Gateway
```
/approve           Approve pending command (gateway)
/deny             Deny pending command
/restart           Restart gateway
/sethome          Set current chat as home channel
/update            Update Hermes to latest
```

### Tools & Skills
```
/tools             Manage tools (interactive)
/toolsets          List toolsets (CLI)
/skills            Search/install skills (CLI)
/skill <name>      Load a skill into session
/cron              Manage cron jobs (interactive)
/reload-mcp        Reload MCP servers
/plugins           List plugins
```

### Utility
```
/branch (/fork)    Branch current session
/browser          Open CDP browser connection
/history           Show conversation history
/save             Save conversation to file
/paste             Attach clipboard image
/image            Attach local image file
/paste            Paste from clipboard
```

### Info
```
/help             Show commands
/commands [page]   Browse all commands
/usage            Token usage
/insights [days]  Usage analytics
/status           Session info
/profile          Active profile info
/quit (/exit,/q) Exit CLI
```

## References

Structured reference docs:

- [CLI Reference](references/cli-reference.md) — All commands with tables
- [Slash Commands](references/slash-commands.md) — In-session `/` commands

Related skills:

- `hermes-config/` — config reference
- `hermes-tools/` — tool reference
- `hermes-gateway/` — gateway management
- `hermes-skills/` — skill management
- `hermes-memory/` — memory management
