# Common Issues & Fixes Reference

Solutions for frequently encountered problems.

## Hermes Won't Start

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

## Gateway Not Connecting

```bash
# Check status
hermes gateway status

# Restart
hermes gateway restart

# Check logs
hermes logs gateway --level ERROR
```

## Channel Not Responding

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

## Skills Not Loading

```bash
# List skills
hermes skills list

# Restart session (skills load at session start)
/reset

# Re-install if needed
hermes skills check
```

## Config Changes Not Applying

Some changes require session restart:

```bash
/reset  # restart session
```

Hot-reload: tools, skills, channel enabled/disabled
Restart required: model provider changes, delegation config

## Model Errors

```bash
hermes doctor
hermes status --all

# Check API keys
hermes config show | grep -i api

# Verify in .env
cat ~/.hermes/.env
```

## Cron Jobs Not Running

```bash
hermes cron list            # See all jobs
hermes cron status          # Scheduler health
hermes cron run <id>       # Test manually
hermes logs --component cron  # Check logs
```

## Hooks Not Firing

```bash
hermes hooks list           # Check configured hooks
hermes hooks doctor         # Diagnose each hook

# Review allowlist
cat ~/.hermes/shell-hooks-allowlist.json
```

## Memory Issues

```bash
hermes memory status        # Check provider
hermes memory setup         # Re-configure if needed
```