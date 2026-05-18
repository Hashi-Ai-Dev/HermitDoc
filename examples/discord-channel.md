---
name: example-discord-channel
description: "Discord bot configuration with basic setup"
version: 1.0.0
author: HermitDoc
---

# Discord Channel Configuration

Minimal Discord bot setup for Hermes.

## Prerequisites

1. Discord Developer account
2. Application with Bot enabled
3. Message Content Intent enabled
4. Bot token

## Configuration

### 1. Get Bot Token

1. Go to https://discord.com/developers/applications
2. Create application → Bot → Build-A-Bot
3. Enable **Message Content Intent**
4. Copy token

### 2. Add to .env

```bash
# ~/.hermes/.env
DISCORD_BOT_TOKEN=your_bot_token_here
```

### 3. Configure Hermes

```bash
hermes config set channels.discord.enabled true
hermes config set channels.discord.token "${DISCORD_BOT_TOKEN}"
hermes config set channels.discord.dmPolicy "pairing"
```

Or edit config.yaml:

```yaml
channels:
  discord:
    enabled: true
    token: "${DISCORD_BOT_TOKEN}"
    dmPolicy: "pairing"
    requireMention: true
```

### 4. Invite Bot

Generate invite URL:
```
https://discord.com/api/oauth2/authorize?client_id=<APP_ID>&permissions=...&scope=bot
```

## Testing

1. Start gateway: `hermes gateway start`
2. Send message in Discord: `@YourBot hello`
3. Bot should respond

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Bot silent | Enable Message Content Intent |
| DM policy blocking | Set `dmPolicy: "open"` or use `hermes pairing approve` |
| Not responding in channel | Check `requireMention` setting |