# Session Lifecycle

How sessions are created, managed, and stored.

## Session Structure

```
~/.hermes/sessions/
├── session-2026-05-18-abc123.json    # Active session
├── session-2026-05-17-def456.json    # Past sessions
└── ...
```

## Session Metadata Schema

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

## Lifecycle Commands

| Command | Action |
|---------|--------|
| Start | `hermes chat` → new session ID |
| Resume | `hermes --resume <id>` → reload session |
| Compress | `/compress` → summarize context |
| End | Session stored, new session on reset |

## Session Management CLI

```bash
hermes sessions list              # List recent sessions
hermes sessions resume SESSION     # Resume a session
hermes sessions export OUT        # Export to JSONL
hermes sessions rename ID TITLE   # Rename a session
hermes sessions delete ID         # Delete a session
hermes sessions prune --older-than DAYS  # Clean up old sessions
hermes sessions stats             # Session store statistics
```

## Session Sources

| Source | Description |
|--------|-------------|
| `cli` | Command-line interface |
| `telegram` | Telegram bot |
| `discord` | Discord bot |
| `gateway` | Gateway API |
| `mcp` | MCP client |

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
/reset      # Clear and start fresh (no compression)
```