# Diagnostic Flow Reference

Systematic approach to diagnosing Hermes issues.

## Step 1 — Run Doctor

```bash
hermes doctor              # Check config and dependencies
hermes doctor --fix        # Auto-fix issues
hermes doctor --deep       # Deep checks (slower)
```

Doctor checks: config validity, API keys, dependencies, gateway status, skill visibility.

## Step 2 — Check Status

```bash
hermes status              # Show all components
hermes status --all        # Full details
```

## Step 3 — Inspect Logs

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

## Step 4 — Check Config

```bash
hermes config check         # Validate config
hermes config show          # View current config
```

## Step 5 — Check Gateway

```bash
hermes gateway status      # Gateway health
hermes gateway restart       # Restart if needed
```

## Step 6 — Check Skills

```bash
hermes skills list          # Show installed skills
hermes skills check          # Check for updates
```

## Diagnostic Checklist

- [ ] `hermes doctor --fix`
- [ ] `hermes status --all`
- [ ] `hermes logs gateway --level ERROR`
- [ ] `hermes config check`
- [ ] `hermes memory status`
- [ ] `/reset` and retry