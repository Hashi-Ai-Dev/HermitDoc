---
name: example-security-hardened
description: "Hardened security configuration for Hermes"
version: 1.0.0
author: HermitDoc
---

# Hardened Security Configuration

Production-ready security settings for Hermes.

## Configuration

```yaml
# config.yaml
security:
  # Redact API keys from conversation logs
  redact_secrets: true
  
  # Enable content filtering (optional)
  tirith_enabled: false
  
  # Blocklist dangerous sites
  website_blocklist:
    - "http://malicious-site.local"
    - "http://phishing-site.local"

privacy:
  # Hash user IDs, strip phone numbers from context
  redact_pii: true

approvals:
  # Always prompt for dangerous commands
  mode: "manual"

delegation:
  # Limit concurrent subagents
  max_concurrent_children: 2
  max_iterations: 30

checkpoints:
  enabled: true
  max_snapshots: 20
```

## File Permissions

```bash
# Secure Hermes home directory
chmod 700 ~/.hermes/
chmod 600 ~/.hermes/config.yaml
chmod 600 ~/.hermes/.env
chmod 600 ~/.hermes/auth.json

# Lock down logs
chmod 640 ~/.hermes/logs/*.log
```

## Shell Hooks Allowlist Review

Regularly review what hooks are allowlisted:

```bash
cat ~/.hermes/shell-hooks-allowlist.json
```

Remove any unknown or unused hooks.

## Security Checklist

- [ ] `approvals.mode` set to `manual`
- [ ] `security.redact_secrets` enabled
- [ ] `privacy.redact_pii` enabled (if needed)
- [ ] File permissions correct
- [ ] Shell hooks allowlist reviewed
- [ ] No `--yolo` in production
- [ ] API keys in `.env`, not in `config.yaml`
- [ ] Checkpointing enabled for rollback capability