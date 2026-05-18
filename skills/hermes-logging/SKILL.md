---
name: hermes-logging
description: "Use when managing logs, debugging issues, or analyzing Hermes behavior. Covers: hermes logs CLI, log files (agent.log, errors.log, gateway.log), log levels (DEBUG/INFO/WARNING/ERROR), log rotation (max_size_mb, backup_count), log filtering, log analysis. Triggers on: log, logs, logging, trace, debug output, error log."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [logging, logs, diagnostics, error-tracking]
    related_skills: [hermes-troubleshooting, hermes-cli, hermes-config]
---

# Hermes Logging Reference

Hermes logs via the `hermes logs` CLI. No manual file access needed.

## Log Files

| Log | Contents |
|-----|----------|
| `agent` (default) | General agent activity |
| `errors` | Error stack traces |
| `gateway` | Messaging platform events |
| `list` | Show all available log files with sizes |

## Log CLI

```bash
# Default (agent.log, last 50 lines)
hermes logs

# Specific log
hermes logs agent
hermes logs errors
hermes logs gateway

# Line count
hermes logs -n 100

# Follow in real time (like tail -f)
hermes logs -f

# Minimum log level
hermes logs --level DEBUG
hermes logs --level INFO
hermes logs --level WARNING
hermes logs --level ERROR

# Filter by session ID
hermes logs --session abc123

# Filter by time
hermes logs --since 1h
hermes logs --since 30m
hermes logs --since 2d

# Filter by component
hermes logs --component gateway
hermes logs --component agent
hermes logs --component tools
hermes logs --component cli
hermes logs --component cron

# List available logs
hermes logs list
```

## Log Configuration

```yaml
# ~/.hermes/config.yaml
logging:
  level: INFO              # DEBUG, INFO, WARNING, ERROR
  max_size_mb: 5           # rotate when file exceeds this
  backup_count: 3           # keep last N rotated files
```

Set via CLI:
```bash
hermes config set logging.level DEBUG
hermes config set logging.max_size_mb 10
```

## Log Analysis Patterns

```bash
# All errors
hermes logs errors --level ERROR

# Recent gateway issues
hermes logs gateway --level WARNING -n 100

# Tool execution
hermes logs --component tools --level DEBUG

# Specific session
hermes logs --session session-2026-05-18-abc123

# Since last hour
hermes logs -f --since 1h
```

## Log Rotation

Logs rotate automatically based on `max_size_mb`. Old logs are compressed and kept based on `backup_count`.

For manual rotation management, use standard tools on the log directory.

## References

- `hermes-troubleshooting/` — using logs to diagnose issues
- `hermes-cli/` — log CLI commands
- `hermes-config/` — logging config keys