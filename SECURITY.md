# Security Policy

## Scope

This security policy covers the HermitDoc public repository, including all skills, scripts, reference documentation, and configuration examples. It **does not** cover:
- Hermes Agent core (report to [Nous Research](https://github.com/NousResearch/hermes-agent/security))
- Third-party services referenced in skills (OpenRouter, Anthropic, etc.)
- User runtime environments, credential files, or personal configurations

## Supported Versions

|| Version | Supported          |
| ------- | ------------------ |
| v1.x    | ✅ Currently active |

---

## Reporting a Vulnerability

If you discover a security issue in HermitDoc, please report it responsibly:

1. **Do NOT** open a public GitHub issue for security vulnerabilities
2. Email the maintainer directly or use GitHub's **private vulnerability reporting** (look for the "Report a vulnerability" link on the repo)
3. Include as much detail as possible:
   - Description of the issue
   - Steps to reproduce
   - Potential impact
   - Suggested remediation (if any)

Response timeline: We aim to acknowledge within 48 hours and resolve within 7 days.

---

## Security Considerations for HermitDoc Users

### Config Files

HermitDoc skills reference `~/.hermes/config.yaml` and `~/.hermes/.env`. These files contain sensitive credentials:
- **Never commit** `config.yaml`, `.env`, or any credential files to version control
- Use `.gitignore` patterns like `config.yaml`, `.env`, `auth.json`
- Store API keys as environment variables, not plaintext in configs

### Secret Redaction

Hermes Agent supports secret redaction via `security.redact_secrets`. Enable it to prevent API keys and tokens from appearing in conversation logs:

```bash
hermes config set security.redact_secrets true
```

This requires a session restart to take effect.

### Command Approval

By default, Hermes prompts before running destructive commands. Keep this enabled:
```bash
hermes config set approvals.mode manual  # recommended
# or
hermes config set approvals.mode smart  # auto-approve low-risk commands
```

### Shell Hooks Allowlist

Shell hooks require explicit allowlisting. Review `~/.hermes/shell-hooks-allowlist.json` regularly.

### YOLO Mode

Never run with `--yolo` or `approvals.mode: off` in production environments. This bypasses all safety checks.

---

## Third-Party Dependencies

HermitDoc references but does not modify Hermes Agent internals. Security of Hermes Agent itself is managed by [Nous Research](https://github.com/NousResearch/hermes-agent).

When adding external references (docs, tools, providers), verify the source is trustworthy and up-to-date.

---

## Disclaimers

- HermitDoc is community-maintained and **not affiliated with Nous Research**
- Security vulnerabilities in Hermes Agent itself should be reported to [Nous Research's security team](https://github.com/NousResearch/hermes-agent/security)
- HermitDoc maintainers are not responsible for misuse of the skills or configurations documented here