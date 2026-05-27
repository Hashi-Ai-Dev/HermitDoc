# Security Configuration Schema

Complete reference for security config keys.

## Command Approvals

### Modes

| Mode | Behavior | When to use |
|------|---------|-------------|
| `manual` | Always prompt before flagged commands | Default, recommended |
| `smart` | Auto-approve low-risk, prompt on high-risk | Trust some commands |
| `off` | Skip all prompts | Never in production |

### Configuration

```yaml
# config.yaml
approvals:
  mode: "manual"  # manual | smart | off

# Or via CLI
hermes config set approvals.mode smart
```

### Destructive Commands (always flagged)

- `rm -rf` or `rm -r /*`
- `git reset --hard`
- `mkfs` or `dd` with device target
- `pkill -f` or `kill -9` on system processes
- Deleting `/etc`, `/var`, `/home`

### Per-Invocation Bypass

```bash
# Single session with no approvals
hermes --yolo

# Or in config
export HERMES_YOLO_MODE=1
```

> [!WARNING]
> Never use `--yolo` or `mode: off` in production.

## Security Configuration Template

```yaml
security:
  # Redact API keys from logs
  redact_secrets: true
  
  # Enable content filtering
  tirith_enabled: false
  
  # Block specific URLs
  website_blocklist:
    - "https://malicious-site.com"

privacy:
  # Hash user IDs, strip phone numbers
  redact_pii: false

approvals:
  # Prompt before dangerous commands
  mode: "manual"  # manual | smart | off
```