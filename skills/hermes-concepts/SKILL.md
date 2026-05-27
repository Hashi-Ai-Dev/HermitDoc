---
name: hermes-concepts
description: "Use when understanding Hermes architecture, concepts, or design. Covers: session system, context management, compression, bootstrap files, agent loop, lifecycle, profiles, checkpointing, context injection. Triggers on: concept, architecture, session, context, bootstrap, compression, lifecycle, how hermes works."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [concepts, architecture, session, context, bootstrap, compression, lifecycle]
    related_skills: [hermes-master, hermes-config, hermes-soul]
    hermes_version: "v2026.5.16"
---

# Hermes Concepts Reference

Deep dive into Hermes Agent's core concepts and architecture.

## Agent Loop

The core Hermes execution cycle:

1. **User Input** → Message, voice, or platform event
2. **Context Assembly** → Bootstrap files + session history + memory
3. **LLM Inference** → Model generates response
4. **Tool Calls** → Execute tools as needed
5. **Response** → Send back to user/platform
6. **State Update** → Update session, memory, compression if needed
7. **Loop** → Continue until task complete or max_turns

## Session System

Sessions track conversation context:

```
~/.hermes/sessions/
├── session-2026-05-18-abc123.json    # Active session
├── session-2026-05-17-def456.json    # Past sessions
└── ...
```

### Session Lifecycle

| Command | Action |
|---------|--------|
| Start | `hermes chat` → new session ID |
| Resume | `hermes --resume <id>` → reload session |
| Compress | `/compress` → summarize context |
| End | Session stored, new session on reset |

### Session Metadata

```json
{
  "id": "session-2026-05-18-abc123",
  "created": "2026-05-18T10:00:00Z",
  "last_active": "2026-05-18T14:30:00Z",
  "model": "anthropic/claude-sonnet-4",
  "profile": "default",
  "source": "cli",
  "message_count": 47,
  "compressed": false
}
```

## Context Management

### Context Assembly Order

When a session starts, context is assembled in this order:

1. **System prompt** (from Hermes core)
2. **SOUL.md** (persona)
3. **USER.md** (user profile)
4. **AGENTS.md** (operating instructions)
5. **Bootstrap files** (IDENTITY.md, HEARTBEAT.md, MEMORY.md, TOOLS.md)
6. **Memory entries** (from `session_search`)
7. **Session history** (conversation turns)
8. **Current input**

### Context Window

Context window is limited by model's `context_length`:

| Model | Context Window |
|-------|---------------|
| Claude 3.5 Sonnet | 200K tokens |
| Gemini 2.0 Flash | 1M tokens |
| DeepSeek Chat V3 | 64K tokens |
| Llama 3.1 | 128K tokens |

Hermes manages context automatically via compression.

## Compression

When context reaches threshold, Hermes compresses:

```yaml
compression:
  enabled: true
  threshold: 0.50    # compress at 50% of context
  target_ratio: 0.20  # compress to 20% of original
```

### Compression Process

1. Identify least-recent relevant messages
2. Generate summary of those messages
3. Replace message sequence with summary
4. Preserve critical context (user prefs, active tasks)
5. Continue session with compressed history

### Manual Compression

```bash
/compress   # Force immediate compression
/reset     # Clear and start fresh (no compression)
```

## Bootstrap Files

Injected on first turn of each session:

| File | Purpose |
|------|---------|
| `SOUL.md` | Persona, tone, boundaries |
| `USER.md` | User profile and preferences |
| `AGENTS.md` | Operating instructions |
| `IDENTITY.md` | Name, emoji, display info |
| `HEARTBEAT.md` | Periodic background tasks |
| `MEMORY.md` | Persistent memory entries |
| `TOOLS.md` | Tool notes and usage patterns |

These files live in `~/.hermes/` and are loaded at session start.

## Agent Loop Lifecycle

```
┌─────────────────────────────────────────────────┐
│                 Session Start                    │
│  Load SOUL.md, USER.md, bootstrap files           │
│  Load memory, session history                    │
└────────────────────┬────────────────────────────┘
                     │
         ┌───────────▼───────────┐
         │   User Input          │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   Context Assembly    │◄── Session history
         │   + Memory            │◄── session_search
         │   + Bootstrap files   │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   LLM Inference       │
         │   (tool calls)        │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   Tool Execution      │
         │   (terminal, file,    │
         │    web, etc.)         │
         └───────────┬───────────┘
                     │
              ┌──────┴──────┐
              │ Compressed? │─── Yes ──► Compress and continue
              └──────┬──────┘
                     │ No
         ┌───────────▼───────────┐
         │   Response Output     │
         │   (text, voice,       │
         │    platform msg)     │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   Max turns reached?  │─── Yes ──► End session
         └───────────┬───────────┘
                     │ No
                     └──► Back to User Input
```

## Checkpoints

Filesystem snapshots for rollback:

```bash
hermes config set checkpoints.enabled true
hermes config set checkpoints.max_snapshots 50
```

```bash
# Create manual checkpoint
/rollback

# List checkpoints
ls ~/.hermes/checkpoints/

# Restore checkpoint
/rollback 2  # restore 2nd most recent
```

## Profiles

Isolated configurations and state:

```
~/.hermes/
├── config.yaml           # Default config
├── profiles/
│   ├── dev/
│   │   ├── config.yaml
│   │   ├── SOUL.md
│   │   ├── skills/
│   │   └── sessions/
│   └── prod/
│       └── ...
```

### Profile Switching

```bash
hermes chat --profile dev
hermes profile use dev
```

## Agent vs Subagent

| Aspect | Hermes Agent | Subagent (delegate_task) |
|--------|--------------|--------------------------|
| Session | Full session with history | Fresh, isolated context |
| Tools | All enabled toolsets | Configurable subset |
| User interaction | Can ask questions | Cannot (self-contained) |
| Lifespan | Long-lived | Task-scoped |
| Memory | Cross-session | Session-only |
| Use case | Ongoing assistance | Parallel work, isolation |

## References

Structured reference docs:

- [Decision Flow](references/decision-flow.md) — Agent loop visualization
- [Session Lifecycle](references/session-lifecycle.md) — Session management
- [Context Assembly](references/context-assembly.md) — Context priority order

Related skills:

- `hermes-master/` — routing and overview
- `hermes-config/` — config keys
- `hermes-soul/` — persona system
- `hermes-memory/` — memory architecture
- `hermes-delegation/` — subagent patterns
- Official concepts docs: https://hermes-agent.nousresearch.com/docs/architecture
