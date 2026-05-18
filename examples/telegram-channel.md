---
name: example-telegram-channel
description: "Telegram bot configuration for Hermes"
version: 1.0.0
author: HermitDoc
---

# Telegram Channel Configuration

Minimal Telegram bot setup for Hermes.

## Prerequisites

1. Telegram account
2. Bot created via @BotFather
3. HTTP API token

## Configuration

### 1. Get Bot Token

1. Open Telegram → search @BotFather
2. Send `/newbot`
3. Follow prompts, copy token

### 2. Add to .env

```bash
# ~/.hermes/.env
TELEGRAM_BOT_TOKEN=123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11
```

### 3. Configure Hermes

```bash
hermes config set channels.telegram.enabled true
hermes config set channels.telegram.botToken "${TELEGRAM_BOT_TOKEN}"
```

Or edit config.yaml:

```yaml
channels:
  telegram:
    enabled: true
    botToken: "${TELEGRAM_BOT_TOKEN}"
    parseMode: "Markdown"
```

### 4. Start Gateway

```bash
hermes gateway start
```

## Testing

1. Open Telegram, find your bot
2. Send `/start`
3. Bot should respond

## Common Commands

Set up via BotFather:
- `/start` — begin conversation
- `/help` — help info
- `/status` — check Hermes status