---
name: example-openrouter-provider
description: "OpenRouter provider configuration with multiple models"
version: 1.0.0
author: HermitDoc
---

# OpenRouter Provider Configuration

Configure OpenRouter as your model provider with multiple models for failover.

## Prerequisites

1. OpenRouter account: https://openrouter.ai
2. API key from dashboard

## Configuration

### 1. Add to .env

```bash
# ~/.hermes/.env
OPENROUTER_API_KEY=sk-or-your-key-here
```

### 2. Configure Hermes

```bash
hermes config set model.default "openrouter/google/gemini-2.0-flash-exp"
hermes config set model.provider "openrouter"
hermes config set model.api_key "${OPENROUTER_API_KEY}"
```

Or edit config.yaml:

```yaml
model:
  default: "openrouter/google/gemini-2.0-flash-exp"
  provider: "openrouter"
  api_key: "${OPENROUTER_API_KEY}"
```

### 3. Add Fallback Models

```yaml
model:
  default: "openrouter/google/gemini-2.0-flash-exp"
  provider: "openrouter"
  api_key: "${OPENROUTER_API_KEY}"
  fallbacks:
    - "openrouter/anthropic/claude-3.5-sonnet"
    - "openrouter/deepseek/deepseek-chat-v3"
```

## Testing

```bash
hermes chat -q "Hello, testing OpenRouter connection"
```

## Popular OpenRouter Models

| Model | Best for |
|-------|----------|
| `google/gemini-2.0-flash-exp` | Fast, capable, good value |
| `anthropic/claude-3.5-sonnet` | Best reasoning |
| `deepseek/deepseek-chat-v3` | Cost-effective |
| `meta-llama/llama-3.3-70b-instruct` | Open source |

## Credential Pool

For high-volume usage, add multiple keys:

```bash
hermes auth add  # add second OpenRouter key
hermes auth list  # see all keys
```