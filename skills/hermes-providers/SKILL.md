---
name: hermes-providers
description: "Use when configuring model providers or selecting models. Covers: hermes model CLI, hermes login/logout, hermes auth (pooled credentials), hermes fallback, real providers (MiniMax, OpenRouter, Anthropic, DeepSeek, Google, Groq, Mistral, xAI and 20+). Triggers on: provider, model, API key, openrouter, anthropic, deepseek, gemini, ollama, groq."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [providers, models, API-keys, openrouter, anthropic, deepseek]
    related_skills: [hermes-config, hermes-cli]
    hermes_version: "v2026.5.16"
---

# Hermes Providers Reference

Real providers supported by Hermes. Use `hermes model` for interactive selection.

## Provider CLI

```bash
hermes model                     # Interactive model/provider picker
hermes login --provider PROVIDER  # OAuth login (nous, openai-codex, qwen-oauth)
hermes logout                   # Clear stored auth
hermes auth list [PROVIDER]    # List pooled credentials
hermes auth remove PROVIDER INDEX  # Remove credential by index
hermes auth reset PROVIDER      # Clear exhaustion status
hermes fallback                 # Manage fallback providers
```

## Supported Providers

| Provider | Models | Auth |
|----------|--------|------|
| MiniMax | MiniMax models | API key |
| OpenRouter | 100+ models | API key |
| Anthropic | Claude 3.5/4 | API key |
| OpenAI | GPT-4o, o1 | API key |
| DeepSeek | DeepSeek Chat/V2 | API key |
| Google | Gemini 1.5/2.0 | API key |
| Groq | Llama/Mixtral | API key |
| Mistral | Mistral/Mixtral | API key |
| xAI | Grok 1/2 | API key |
| Nous Portal | Nous models | OAuth |
| Kilo Code | Code models | API key |
| Kimi/Moonshot | Moonshot | API key |
| Alibaba/DashScope | Qwen | API key |
| Z.AI/GLM | GLM | API key |
| Xiaomi MiMo | MiMo | API key |
| Hugging Face | Inference endpoints | Token |
| Ollama | Local models | None (local) |
| AI Gateway (Vercel) | Proxy | API key |
| OpenCode | Code models | API key |
| Custom endpoint | Any | Config |

## Credential Setup

### API Key
Set in `~/.hermes/.env`:
```bash
MINIMAX_API_KEY=sk-...
OPENROUTER_API_KEY=sk-or-...
ANTHROPIC_API_KEY=sk-ant-...
```

Then select in `hermes model`.

### OAuth
```bash
hermes login --provider nous
hermes login --provider openai-codex
hermes login --provider qwen-oauth
```

### Credential Pools

```bash
# Add multiple keys for the same provider
hermes auth add  # prompts interactively

# List all
hermes auth list

# Remove specific key
hermes auth remove openrouter 1

# Reset exhaustion (rate limited)
hermes auth reset openrouter
```

## Fallback Providers

When primary model fails, Hermes tries fallback providers:

```bash
hermes fallback  # manage fallback chain
```

Configure in config or interactively.

## Common Issues

**"Model not found":**
- Check model ID format: `provider/model-id`
- Verify API key set: `hermes status --all`
- Check provider is up

**"Rate limited":**
```bash
hermes auth add          # add another key
hermes auth reset PROVIDER  # reset exhaustion
```

**"Invalid API key":**
- Verify key in `.env`
- Check key is active on provider dashboard

## References

- `hermes-config/` — provider config keys
- `hermes-cli/` — model CLI commands
- `hermes-auth/` — credential management
