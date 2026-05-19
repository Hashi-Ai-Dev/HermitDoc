---
name: hermes-channels
description: "Use when setting up messaging channels. Covers: Discord, Telegram, Slack, WhatsApp, Signal, and more. Channel config keys, bot tokens, DM policies, requireMention, free_response_channels, allowed_channels, auto_thread, reactions, channel_prompts. Triggers on: channel, discord, telegram, slack, whatsapp, setup channel, bot."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [channels, discord, telegram, slack, whatsapp, messaging, bot]
    related_skills: [hermes-gateway, hermes-config, hermes-install]
    hermes_version: "2026.x"
---

# Hermes Channels Reference

Guide to configuring messaging channels in Hermes. All channels are configured via `config.yaml` and the `hermes gateway setup` wizard.

## Supported Channels

Discord, Telegram, Slack, WhatsApp, Signal, and more. Run `hermes gateway setup` for the interactive wizard.

## Discord Setup

### 1. Create Application

1. Go to https://discord.com/developers/applications
2. Create application → Bot → Build-A-Bot
3. Enable **Message Content Intent** (required)
4. Copy Bot Token

### 2. Configure

```yaml
# ~/.hermes/config.yaml
channels:
  discord:
    token: "${DISCORD_BOT_TOKEN}"  # set in .env
    require_mention: true           # only respond when pinged
    free_response_channels: ''      # or list of channel IDs that don't need mention
    allowed_channels: ''           # restrict to specific channels
    auto_thread: true             # auto-create threads
    reactions: true               # add reaction emojis to responses
    channel_prompts: {}          # per-channel prompt overrides
    server_actions: ''           # server-level action config
```

### 3. Invite Bot

Generate invite URL:
```
https://discord.com/api/oauth2/authorize?client_id=<APP_ID>&permissions=...&scope=bot
```

## Telegram Setup

### 1. Create Bot

1. DM `@BotFather` on Telegram
2. `/newbot` → follow prompts
3. Copy HTTP API token

### 2. Configure

```yaml
channels:
  telegram:
    botToken: "${TELEGRAM_BOT_TOKEN}"  # set in .env
    reactions: false
    channel_prompts: {}
```

### 3. Start

```bash
hermes gateway start
```

## Slack Setup

### 1. Create App

1. https://api.slack.com/apps → Create New App
2. Enable **Socket Mode**
3. Add Bot Token scopes: `chat:write`, `app_mentions:read`, etc.
4. Install to workspace → copy Bot Token (`xoxb-...`)

### 2. Configure

```yaml
channels:
  slack:
    botToken: "${SLACK_BOT_TOKEN}"
    signingSecret: "${SLACK_SIGNING_SECRET}"
    channel_prompts: {}
```

### 3. Setup

```bash
hermes slack         # Run Slack integration helpers
hermes gateway setup  # Interactive platform setup
```

## WhatsApp Setup

```bash
hermes whatsapp      # Set up WhatsApp integration wizard
```

## Channel Config Reference

All keys for `channels`:

| Key | Type | Description |
|-----|------|-------------|
| `discord.token` | string | Bot token |
| `discord.require_mention` | bool | Only respond when pinged |
| `discord.free_response_channels` | string | Channel IDs that don't need mention |
| `discord.allowed_channels` | string | Restrict to specific channels |
| `discord.auto_thread` | bool | Auto-create threads |
| `discord.reactions` | bool | Add reaction emojis |
| `discord.channel_prompts` | object | Per-channel prompt overrides |
| `telegram.botToken` | string | Bot token |
| `telegram.reactions` | bool | Enable reactions |
| `slack.botToken` | string | Bot token (xoxb-...) |
| `slack.signingSecret` | string | Signing secret |
| `whatsapp` | object | WhatsApp config |

## Pairing

For DM authorization:

```bash
hermes pairing list              # see pending requests
hermes pairing approve <CODE>     # approve a user
```

## Common Fixes

**Discord bot silent:**
- Enable Message Content Intent in Developer Portal
- Check bot token in `.env`
- Verify `require_mention` setting

**Telegram not responding:**
- Check bot token in `.env`
- Verify `hermes gateway status`

## References

- `hermes-gateway/` — gateway management
- `hermes-cli/` — gateway CLI commands
- `hermes-config/` — channel config keys</parameter>
