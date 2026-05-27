# Context Assembly Order

When a session starts, context is assembled in this order:

## Context Priority

| Priority | Source | Description |
|----------|--------|-------------|
| 1 | System prompt | From Hermes core |
| 2 | SOUL.md | Persona |
| 3 | USER.md | User profile and preferences |
| 4 | AGENTS.md | Operating instructions |
| 5 | Bootstrap files | IDENTITY.md, HEARTBEAT.md, MEMORY.md, TOOLS.md |
| 6 | Memory entries | From `session_search` |
| 7 | Session history | Conversation turns |
| 8 | Current input | User's current message |

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

## Context Window Limits

Context window is limited by model's `context_length`:

| Model | Context Window |
|-------|---------------|
| Claude 3.5 Sonnet | 200K tokens |
| Gemini 2.0 Flash | 1M tokens |
| DeepSeek Chat V3 | 64K tokens |
| Llama 3.1 | 128K tokens |

Hermes manages context automatically via compression.

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