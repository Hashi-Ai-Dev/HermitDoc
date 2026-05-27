# Logs Reference

Complete reference for log management.

## Log Commands

```bash
hermes logs agent            # Default agent log
hermes logs errors           # Error log
hermes logs gateway          # Gateway log
hermes logs --level DEBUG    # Debug output
hermes logs --session abc123 # Filter by session ID
hermes logs --component tools # Tool execution logs
hermes logs --since 30m -f   # Follow last 30 minutes
```

## Log Levels

| Level | Description |
|-------|-------------|
| DEBUG | Detailed diagnostic info |
| INFO | General operational info |
| WARNING | Potential issues |
| ERROR | Errors and failures |

## Log File Locations

| Log | Path |
|-----|------|
| Agent | `~/.hermes/logs/agent.log` |
| Errors | `~/.hermes/logs/errors.log` |
| Gateway | `~/.hermes/logs/gateway.log` |

## Filtering Examples

| Command | Purpose |
|---------|---------|
| `hermes logs --level ERROR` | Show only errors |
| `hermes logs --since 1h` | Last hour only |
| `hermes logs --session abc123` | Specific session |
| `hermes logs --component tools` | Tool execution only |