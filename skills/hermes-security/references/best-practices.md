# Security Best Practices

Security guidelines and checklist.

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