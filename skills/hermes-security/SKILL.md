---
name: hermes-security
description: "Use when configuring security settings, command approvals, secret management, or sandboxing. Covers: approvals mode, YOLO mode, secret redaction, PII redaction, shell hooks allowlist, sandboxing, command safety, credential security, security config. Triggers on: security, approval, YOLO, secret, redaction, sandbox, safe, dangerous, permissions."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [security, approvals, YOLO, secrets, redaction, sandbox, permissions, auth]
    related_skills: [hermes-config, hermes-troubleshooting, hermes-cli]
    hermes_version: "v2026.5.16"
---

# Hermes Security Reference

Complete guide to Hermes security configuration and best practices.

## Security Model Overview

Hermes has layered security:
1. **Command approval** — prompt before dangerous commands
2. **Secret redaction** — mask API keys in logs
3. **PII redaction** — protect user data in context
4. **Shell hooks allowlist** — control hook execution
5. **Sandboxing** — isolate tool execution

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

## Secret Redaction

Prevents API keys and tokens from appearing in conversation logs:

```bash
# Enable
hermes config set security.redact_secrets true

# Restart required — changes don't apply mid-session
```

With redaction enabled, strings matching these patterns are masked:
- `sk-...` (OpenAI, Anthropic)
- `sk-or-...` (OpenRouter)
- `Bearer ...`
- `api_key=...`
- `token=...`
- Long alphanumeric strings matching API key format

> [!NOTE]
> Redaction must be enabled at startup. Toggling mid-session has no effect.

## PII Redaction

Separate from secret redaction. Hashes user IDs and strips phone numbers:

```bash
# Enable
hermes config set privacy.redact_pii true

# Disable (default)
hermes config set privacy.redact_pii false
```

## Shell Hooks Allowlist

Some shell-hook integrations require explicit allowlisting:

- First time a hook wants to run, Hermes prompts interactively
- Decisions stored in `~/.hermes/shell-hooks-allowlist.json`
- Review periodically:
  ```bash
  cat ~/.hermes/shell-hooks-allowlist.json
  ```

Remove entries you don't trust:
```bash
# Edit the allowlist
nano ~/.hermes/shell-hooks-allowlist.json
```

## Credential Security

### API Keys

Store in `~/.hermes/.env`, never in `config.yaml`:

```bash
# In .env
ANTHROPIC_API_KEY=sk-ant-...
OPENROUTER_API_KEY=sk-or-...

# In config.yaml (reference only)
model:
  api_key: "${ANTHROPIC_API_KEY}"
```

### Credential Pools

Rotate across multiple API keys automatically:

```bash
hermes auth add                # add more credentials
hermes auth list              # see all
hermes auth remove P INDEX    # remove one
hermes auth reset PROVIDER     # clear exhaustion
```

### File Permissions

```bash
# Secure your Hermes home
chmod 700 ~/.hermes/
chmod 600 ~/.hermes/config.yaml
chmod 600 ~/.hermes/.env
chmod 600 ~/.hermes/auth.json
```

## Sandboxing

Isolate tool execution in containers:

```bash
# Check sandbox status
hermes sandbox status

# Enable sandboxing (if supported)
hermes config set sandbox.enabled true
```

Sandboxing limits:
- File system access (scoped to project)
- Network access (configurable)
- Process execution (containerized)

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

## Best Practices

1. **Never use `--yolo` in production**
2. **Keep `approvals.mode: manual`** for sensitive environments
3. **Enable secret redaction** if sharing logs
4. **Review shell hooks allowlist** regularly
5. **Use credential pools** instead of single keys
6. **Set proper file permissions** on config and .env
7. **Don't commit secrets** to version control

## Security Checklist

- [ ] `approvals.mode` set to `manual` or `smart`
- [ ] `security.redact_secrets` enabled (if sharing logs)
- [ ] API keys in `.env`, not in `config.yaml`
- [ ] File permissions correct: `chmod 600` on sensitive files
- [ ] Shell hooks allowlist reviewed
- [ ] No `--yolo` in production
- [ ] Regular `hermes doctor` checks

## References

Structured reference docs:

- [Config Reference](references/config-reference.md) — Security config schema
- [Secrets Redaction](references/secrets-redaction.md) — API key protection
- [Best Practices](references/best-practices.md) — Security guidelines

Related skills:

- `hermes-config/` — security config keys
- `hermes-cli/` — auth management
- `hermes-troubleshooting/` — security issues
- Official security docs: https://hermes-agent.nousresearch.com/docs/security
