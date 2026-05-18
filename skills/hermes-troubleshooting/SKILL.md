---
name: hermes-troubleshooting
description: "Use when diagnosing issues or fixing broken Hermes setups. Covers: hermes doctor, hermes config check, hermes status, hermes logs, hermes hooks doctor, common error patterns, gateway issues, pairing problems. Triggers on: troubleshooting, doctor, fix, error, debug, broken, not working, failed, issue."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [troubleshooting, debugging, doctor, diagnosis, error-codes, fix]
    related_skills: [hermes-cli, hermes-config, hermes-logging, hermes-master]
---

# Hermes Troubleshooting Reference

Systematic approach to diagnosing and fixing Hermes issues.

## Diagnostic Flow

### Step 1 — Run Doctor

```bash
hermes doctor              # Check config and dependencies
hermes doctor --fix        # Auto-fix issues
hermes doctor --deep       # Deep checks (slower)
```

Doctor checks: config validity, API keys, dependencies, gateway status, skill visibility.

### Step 2 — Check Status

```bash
hermes status              # Show all components
hermes status --all         # Full details
```

### Step 3 — Inspect Logs

```bash
hermes logs                 # agent.log last 50 lines
hermes logs -f              # Follow in real time
hermes logs errors          # errors.log
hermes logs gateway         # gateway.log
hermes logs --level ERROR   # All errors
hermes logs --since 1h     # Last hour
hermes logs --component tools  # Filter by component
hermes logs list            # List available log files
```

### Step 4 — Check Config

```bash
hermes config check         # Validate config
hermes config show          # View current config
```

### Step 5 — Check Gateway

```bash
hermes gateway status      # Gateway health
hermes gateway restart       # Restart if needed
```

### Step 6 — Check Skills

```bash
hermes skills list          # Show installed skills
hermes skills check          # Check for updates
```

## Common Issues & Fixes

### Hermes Won't Start

**Symptoms:** `hermes chat` hangs or crashes.

```bash
# Check config
hermes config check

# Fix automatically
hermes doctor --fix

# Check for running process
ps aux | grep hermes | grep -v grep

# Kill and retry
pkill -f hermes
hermes chat
```

### Gateway Not Connecting

```bash
# Check status
hermes gateway status

# Restart
hermes gateway restart

# Check logs
hermes logs gateway --level ERROR
```

### Channel Not Responding

```bash
# Verify gateway is up
hermes gateway status

# Check pairing
hermes pairing list

# Approve pending if needed
hermes pairing approve <CODE>

# Check logs
hermes logs gateway
```

### Skills Not Loading

```bash
# List skills
hermes skills list

# Restart session (skills load at session start)
/reset

# Re-install if needed
hermes skills check
```

### Config Changes Not Applying

Some changes require session restart:

```bash
/reset  # restart session
```

Hot-reload: tools, skills, channel enabled/disabled
Restart required: model provider changes, delegation config

### Model Errors

```bash
hermes doctor
hermes status --all

# Check API keys
hermes config show | grep -i api

# Verify in .env
cat ~/.hermes/.env
```

### Cron Jobs Not Running

```bash
hermes cron list            # See all jobs
hermes cron status          # Scheduler health
hermes cron run <id>       # Test manually
hermes logs --component cron  # Check logs
```

### Hooks Not Firing

```bash
hermes hooks list           # Check configured hooks
hermes hooks doctor         # Diagnose each hook

# Review allowlist
cat ~/.hermes/shell-hooks-allowlist.json
```

### Memory Issues

```bash
hermes memory status        # Check provider
hermes memory setup         # Re-configure if needed
```

## Logs Reference

```bash
hermes logs agent            # Default agent log
hermes logs errors           # Error log
hermes logs gateway          # Gateway log
hermes logs --level DEBUG    # Debug output
hermes logs --session abc123 # Filter by session ID
hermes logs --component tools # Tool execution logs
hermes logs --since 30m -f   # Follow last 30 minutes
```

## Reference Checklist

- [ ] `hermes doctor --fix`
- [ ] `hermes status --all`
- [ ] `hermes logs gateway --level ERROR`
- [ ] `hermes config check`
- [ ] `hermes memory status`
- [ ] `/reset` and retry

## References

- `hermes-cli/` — CLI commands
- `hermes-config/` — config reference
- `hermes-logging/` — log management
- `hermes-gateway/` — gateway issues
- `hermes-skills/` — skill problems