---
name: example-anthropic-deepseek
description: "Multi-provider setup with Anthropic as primary and DeepSeek as fallback"
version: 1.0.0
author: HermitDoc
---

# Multi-Provider Configuration

Anthropic primary with DeepSeek fallback.

## Prerequisites

1. `ANTHROPIC_API_KEY` from https://console.anthropic.com
2. `DEEPSEEK_API_KEY` from https://platform.deepseek.com

## Configuration

### 1. Add to .env

```bash
# ~/.hermes/.env
ANTHROPIC_API_KEY=sk-ant-your-key-here
DEEPSEEK_API_KEY=sk-your-deepseek-key-here
```

### 2. Configure Hermes

```yaml
# config.yaml
model:
  default: "anthropic/claude-sonnet-4-20250514"
  provider: "anthropic"
  api_key: "${ANTHROPIC_API_KEY}"
  fallbacks:
    - provider: "deepseek"
      model: "deepseek/deepseek-chat-v3"
      api_key: "${DEEPSEEK_API_KEY}"
    - provider: "openrouter"
      model: "openrouter/google/gemini-2.0-flash-exp"
      api_key: "${OPENROUTER_API_KEY}"
```

## Testing

```bash
hermes chat -q "Test multi-provider failover"
```

If primary fails, Hermes automatically switches to fallback.