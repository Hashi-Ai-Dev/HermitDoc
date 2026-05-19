---
name: hermes-memory
description: "Use when configuring Hermes memory, external providers, or built-in memory. Covers: hermes memory CLI, built-in memory (MEMORY.md/USER.md), Honcho, Mem0, holographic, hindsight, and 8+ providers. Also covers: session_search, memory_char_limit, user_char_limit. Triggers on: memory, session_search, honcho, mem0, holographic, built-in memory, memory provider."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [memory, session-search, providers, honcho, mem0, built-in, persistent]
    related_skills: [hermes-config, hermes-cli, hermes-concepts]
    hermes_version: "2026.x"
---

# Hermes Memory Reference

Complete guide to Hermes memory — built-in and external providers.

## Memory Architecture

Two layers always active:

1. **Built-in memory** — `MEMORY.md` and `USER.md` in `~/.hermes/`. Always active.
2. **External providers** — Optional layer via plugins.

Tools: `session_search` (semantic search), `memory` (read/write entries).

## Built-in Memory

Always active regardless of external provider:

```bash
hermes memory status          # show current config
hermes memory reset           # erase MEMORY.md and USER.md
hermes memory off             # disable external provider (built-in only)
```

Files:
```
~/.hermes/MEMORY.md           # Persistent memory entries
~/.hermes/USER.md             # User profile and preferences
```

These are injected into session context automatically.

## External Providers

Optional plugins that provide semantic memory, user modeling, cross-session context:

### Available Providers

| Provider | Type | Setup |
|----------|-------|--------|
| `honcho` | API key / local | Nous Research |
| `mem0` | API key | Managed service |
| `openviking` | API key | OpenViking |
| `hindsight` | API key / local | Local-first |
| `holographic` | local | No external dependency |
| `retaindb` | API key | Retention database |
| `byterover` | API key | ByteRover |
| `supermemory` | API key | SuperMemory |

### Configure a Provider

```bash
hermes memory setup           # Interactive provider selection and configuration
```

This wizard guides you through provider selection and API key setup.

### Manual Config

```yaml
# ~/.hermes/config.yaml
memory:
  memory_enabled: true       # enable semantic memory
  user_profile_enabled: true  # enable user profiling
  provider: 'mem0'           # provider name (or empty for built-in only)
  memory_char_limit: 2200    # max chars per memory entry
  user_char_limit: 1375      # max chars per user profile entry
```

## Memory Tools

| Tool | Purpose |
|------|---------|
| `session_search` | Semantic search across past conversations |
| `memory` (read) | Read memory entries from built-in |
| `memory` (write) | Write persistent entries to built-in |

## session_search

```python
# In session
session_search(query="Docker deployment setup", limit=5)
session_search(query="how did we configure the cron job", limit=10)
```

Returns conversation excerpts ranked by semantic similarity.

## Memory CLI Reference

```bash
hermes memory status          # Show current provider and config
hermes memory setup           # Interactive setup wizard
hermes memory off             # Disable external provider (built-in only)
hermes memory reset           # Erase all built-in memory (MEMORY.md and USER.md)
```

## Common Fixes

**Memory returning nothing:**
- Index builds over time — wait a few sessions
- Check `hermes memory status` for provider config
- Try `hermes memory setup` to reconfigure

**Provider not connecting:**
- Verify API key in `.env`
- Check provider documentation for correct setup
- Try `hermes memory setup` interactive wizard

**Built-in memory not persisting:**
- Check files exist: `ls ~/.hermes/MEMORY.md ~/.hermes/USER.md`
- Files may be empty — use `memory` tool to write entries

## References

- `hermes-config/` — memory config keys
- `hermes-concepts/` — session and context system
- `hermes-cli/` — memory CLI commands</parameter>
