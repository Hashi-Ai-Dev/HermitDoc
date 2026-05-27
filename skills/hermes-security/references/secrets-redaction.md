# Secret Redaction Reference

Prevents API keys and tokens from appearing in conversation logs.

## Enable Redaction

```bash
# Enable
hermes config set security.redact_secrets true

# Restart required — changes don't apply mid-session
```

## Patterns Redacted

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

## Credential Storage

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