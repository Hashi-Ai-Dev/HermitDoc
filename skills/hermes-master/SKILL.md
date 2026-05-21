---
name: hermes-master
description: "Use when routing unclassified Hermes questions, or when no specific skill matches. Top-level routing hub — maps questions to the right skill. Covers: SOUL.md, sessions, compression, context, profiles, multi-agent, delegation patterns, agent loop, lifecycle, bootstrap. Triggers on: hermes expert, hermes help, how does hermes work, hermes overview, system doctor, gateway, default config, profiles vs config."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [hermes, master, routing, overview, concepts, architecture]
    related_skills: [hermes-config, hermes-skills, hermes-delegation, hermes-concepts, hermes-troubleshooting]
    hermes_version: "v2026.5.16"
---

# Hermes Master Reference

Comprehensive Hermes Agent knowledge base. This is the top-level skill that routes to specialized skills.

> **⚠️ Community project:** HermitDoc is not affiliated with Nous Research. Always cross-reference with official docs at https://hermes-agent.nousresearch.com/docs/

## Skill Map

| Skill | When to use |
|-------|-------------|
| `hermes-config` | config.yaml keys, env vars, profiles, credentials, model routing |
| `hermes-skills` | Skill authoring, installation, publishing, hub |
| `hermes-delegation` | Subagent spawning, reusable configs, toolsets, parallelization |
| `hermes-memory` | session_search, memories, user profiles, Honcho, Mem0 |
| `hermes-cron` | Scheduling, cron jobs, delivery targets, automation |
| `hermes-troubleshooting` | Diagnosis, error codes, doctor, gateway runbook |
| `hermes-logging` | Log files, log levels, gateway logs |
| `hermes-security` | Approvals, YOLO mode, secret redaction, sandboxing |
| `hermes-hooks` | Shell hooks, allowlist, pre/post execution triggers |
| `hermes-channels` | Discord, Telegram, Slack, WhatsApp, Signal, Matrix, routing |
| `hermes-gateway` | Platform integrations, home channels, pairing |
| `hermes-mcp` | MCP server setup, tool registration, stdio/HTTP |
| `hermes-platforms` | Linux, macOS, WSL2, Windows, Termux, Docker |
| `hermes-install` | Install guides for all platforms and methods |
| `hermes-voice` | TTS/STT providers, voice mode, transcription |
| `hermes-providers` | Model providers: OpenRouter, Anthropic, DeepSeek, Gemini... |
| `hermes-tools` | Tool reference: terminal, file, browser, vision... |
| `hermes-cli` | All hermes CLI commands |
| `hermes-soul` | SOUL.md authoring, personality, tone |
| `hermes-concepts` | Architecture, session, compaction, bootstrap, agent loop |
| `hermes-skill-authoring` | SKILL.md format, frontmatter, validation |

## Quick Reference

### Docs URLs (always current)
| Topic | URL |
|-------|-----|
| Main docs | https://hermes-agent.nousresearch.com/docs/ |
| Config reference | https://hermes-agent.nousresearch.com/docs/user-guide/configuration |
| CLI commands | https://hermes-agent.nousresearch.com/docs/ |
| Skills hub | https://hermes-agent.nousresearch.com/docs/skills |
| MCP integration | https://hermes-agent.nousresearch.com/docs/integrations/mcp |
| Messaging | https://hermes-agent.nousresearch.com/docs/user-guide/messaging |
| Source | https://github.com/NousResearch/hermes-agent |

### Key Paths
```
~/.hermes/config.yaml       Main configuration
~/.hermes/.env              API keys and secrets
~/.hermes/skills/           Installed skills
~/.hermes/sessions/         Session transcripts
~/.hermes/logs/             Gateway and error logs
~/.hermes/auth.json         OAuth tokens and credential pools
~/.hermes/profiles/<name>/  Isolated profile configs
```

### Config Location
```
~/.hermes/config.yaml
```

### Logs
```
~/.hermes/logs/                     # Gateway logs
~/.hermes/sessions/                 # Session transcripts
```

### Gateway Management
```bash
hermes doctor               # diagnose + fix
hermes doctor --fix         # auto-repair
hermes status [--all]       # component status
hermes gateway run          # start foreground
hermes gateway start        # start background service
hermes gateway stop        # stop service
hermes gateway restart      # restart service
hermes gateway status      # check status
```

### Validate Config
```bash
hermes config check         # check config validity
hermes config edit          # open in $EDITOR
```

## Architecture Overview

Hermes Agent is a self-improving AI agent by Nous Research. Key features:

- **Self-improving through skills** — learns from experience, persists knowledge as reusable skills
- **Persistent memory across sessions** — remembers users, preferences, environment
- **Multi-platform gateway** — Telegram, Discord, Slack, WhatsApp, Signal, Matrix, Email, and 15+ more
- **Provider-agnostic** — swap models mid-workflow; credential pools rotate automatically
- **Profiles** — run multiple isolated instances with separate configs, sessions, skills, memory
- **Extensible** — plugins, MCP servers, webhooks, cron scheduling, full Python ecosystem

Architecture layers:
1. **CLI/Interface** — chat, voice, messaging platforms
2. **Agent Core** — LLM orchestration, tool calling, session management
3. **Gateway** — multi-platform messaging surface
4. **Skills System** — procedural memory, loaded on-demand
5. **Memory System** — session_search, user profiles, Honcho/Mem0 plugins
6. **Tools** — 70+ built-in tools (terminal, file, web, browser, vision, etc.)

## Memory Architecture

Three layers:
1. **Session memory** — conversation context within a session (built-in)
2. **Semantic memory** — `session_search` across past conversations
3. **Persistent user memory** — user profiles, preferences (Honcho, Mem0, or builtin)

Tools: `session_search` (semantic), `read_file`, `memory`

## Agent Bootstrap Files

Injected on first turn of session:
- `SOUL.md` — persona, boundaries, tone
- `USER.md` — user profile
- `AGENTS.md` — operating instructions
- `HEARTBEAT.md` — periodic task list
- `IDENTITY.md` — name/emoji
- `MEMORY.md` — persistent memory entries

## Session Management

| Command | Action |
|---------|--------|
| `/reset` | Fresh session, reload skills |
| `/new` | Same as reset |
| `/compress` | Manually compress context |
| `/undo` | Remove last exchange |
| `/retry` | Resend last message |
| `/save` | Save conversation to file |
| `/title [name]` | Name the session |
| `/resume [name]` | Resume a named session |

## Delegation Patterns

Hermes can spawn subagents via `delegate_task`:
- Up to 3 concurrent by default (`delegation.max_concurrent_children`)
- Each gets isolated context and toolsets
- Useful for: parallel research, multi-track coding, code review + testing
- Max iterations per subagent: 50 (configurable)

## Compression / Context Management

When context window fills:
1. **Automatic compression** — `compression.threshold` triggers context summarization
2. **Manual compress** — `/compress` forces immediate compaction
3. **Session split** — old sessions stored, new session continues

Config:
```yaml
compression:
  enabled: true
  threshold: 0.50      # compress when 50% of context used
  target_ratio: 0.20   # aim to compress to 20% of original
```

## Profiles

Profiles isolate configs, sessions, skills, and memory:
```bash
hermes profile create dev --clone-from default
hermes profile use dev
hermes profile delete dev
hermes profile export dev --out dev.tar.gz
hermes profile import dev.tar.gz
```

Profile directory: `~/.hermes/profiles/<name>/`

## CLI Essentials

```bash
hermes chat                    # interactive chat
hermes chat -q "question"      # single query
hermes doctor                   # diagnose
hermes skills list             # show skills
hermes skills search <query>   # find skills
hermes config edit             # edit config
hermes model                   # change provider
hermes gateway run             # start messaging
```

## References

- `hermes-config/` — full config reference
- `hermes-skills/` — skill management
- `hermes-delegation/` — subagent patterns
- `hermes-memory/` — memory backends
- `hermes-concepts/` — architecture deep-dive
- `hermes-troubleshooting/` — diagnosis flows
- `hermes-providers/` — all model providers
