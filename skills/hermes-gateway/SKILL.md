---
name: hermes-gateway
description: "Use when managing the Hermes gateway, platform integrations, home channels, or pairing. Covers: gateway run/start/stop/restart/status/install, home channel, pairing management, channel_directory, platform status. Triggers on: gateway, home channel, pairing, platform status, run gateway."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [gateway, platform, home-channel, pairing, broadcast, messaging]
    related_skills: [hermes-channels, hermes-cli, hermes-config]
    hermes_version: "v2026.5.16"
---

# Hermes Gateway Reference

The gateway manages all messaging platform connections (Discord, Telegram, WhatsApp, Slack) in a single process.

## Gateway CLI

```bash
hermes gateway run              # Start foreground (recommended for WSL, Docker, Termux)
hermes gateway start            # Start background systemd/launchd service
hermes gateway stop             # Stop background service
hermes gateway restart          # Restart service
hermes gateway status          # Show gateway status
hermes gateway install          # Install as systemd/launchd service
hermes gateway uninstall        # Uninstall service
hermes gateway setup            # Interactive platform setup wizard
hermes gateway migrate-legacy  # Remove legacy hermes.service units
```

**No persistent port** — the gateway manages connections internally. Do not manually expose ports.

## Home Channel

Set where bot responds by default:

```bash
# In the chat where you want to set home:
/sethome
```

## Pairing

Manage user access via pairing codes:

```bash
hermes pairing list              # Show pending + approved users
hermes pairing approve CODE      # Approve a pairing code
hermes pairing revoke USER_ID    # Revoke user access
hermes pairing clear-pending   # Clear all pending codes
```

Users request a pairing code → you approve → they gain access.

## Channel Directory

Located at `~/.hermes/channel_directory.json`:

```json
{
  "home": "discord:123456789"
}
```

Format: `platform:identifier` (e.g., `discord:123456789`, `telegram:-100123456789`)

## Gateway Logs

```bash
# View gateway logs
hermes logs gateway

# Follow in real time
hermes logs gateway -f

# All gateway errors
hermes logs gateway --level ERROR

# Filter by component
hermes logs gateway --component gateway
```

## Gateway Configuration

```yaml
# ~/.hermes/config.yaml — channel-level config
channels:  # or per-platform keys
  discord:
    require_mention: true
    free_response_channels: ''
    allowed_channels: ''
    auto_thread: true
    reactions: true
    channel_prompts: {}
    server_actions: ''
  telegram:
    reactions: false
    channel_prompts: {}
  slack:
    channel_prompts: {}
  whatsapp: {}
```

## Troubleshooting

**Gateway won't start:**
```bash
# Check if already running
ps aux | grep hermes | grep gateway

# Kill existing
pkill -f hermes-gateway

# Retry
hermes gateway run
```

**Platform not connecting:**
```bash
hermes gateway status
hermes gateway setup
```

## References

- `hermes-channels/` — individual channel setup
- `hermes-cli/` — gateway CLI commands
- `hermes-config/` — channel config keys</parameter>
