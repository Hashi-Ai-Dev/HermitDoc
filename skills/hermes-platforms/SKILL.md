---
name: hermes-platforms
description: "Use when deploying Hermes on specific platforms or environments. Covers: Linux distros, macOS, WSL2, Windows, Android/Termux, Docker, cloud platforms, serverless, SSH, performance tuning per platform. Triggers on: platform, linux distro, ubuntu, debian, fedora, macos, wsl, termux, docker, aws, digitalocean, railway."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [platforms, linux, macos, windows, wsl, termux, docker, cloud, aws, deployment]
    related_skills: [hermes-install, hermes-config, hermes-gateway]
    hermes_version: "v2026.5.16"
---

# Hermes Platforms Reference

Platform-specific deployment and configuration guidance.

## Linux Distros

### Ubuntu / Debian

```bash
# Systemd service for auto-start
sudo cat > /etc/systemd/system/hermes.service <<EOF
[Unit]
Description=Hermes Agent
After=network.target

[Service]
Type=simple
User=$USER
ExecStart=/usr/local/bin/hermes gateway run
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable hermes
sudo systemctl start hermes
```

### Fedora / RHEL

Same as Ubuntu, systemd works identically.

### Arch Linux

```bash
# Install Node.js
sudo pacman -S nodejs npm

# Install Hermes
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

## macOS

### LaunchAgent (auto-start)

```xml
~/Library/LaunchAgents/com.hermes.agent.plist:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.hermes.agent</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/local/bin/hermes</string>
    <string>gateway</string>
    <string>run</string>
  </array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
</dict>
</plist>
```

## Windows (WSL2)

### Performance Tips

- Use WSL2, not WSL1
- Store config in WSL home, not Windows filesystem
- Use Windows Terminal for better Unicode support

### Known Issues

- Voice features may not work
- Some terminal features limited

## Android (Termux)

### Performance Tuning

```bash
# Use smaller models
hermes config set model.default "google/gemini-nano"

# Reduce max turns
hermes config set agent.max_turns 30
```

### Storage

```bash
# Termux has limited storage
# Use SD card for large files
termux-setup-storage
ln -s /sdcard/hermes ~/.hermes
```

## Docker

### Minimal Image

```dockerfile
FROM ghcr.io/nousresearch/hermes-agent
WORKDIR /workspace
CMD ["hermes", "gateway", "run"]
```

### Resource Limits

```bash
docker run -d \
  --name hermes \
  --memory="2g" \
  --cpus="1.0" \
  -v ~/.hermes:/root/.hermes \
  ghcr.io/nousresearch/hermes-agent
```

## Cloud Platforms

### AWS EC2

```bash
# SSH into instance
ssh -i key.pem ubuntu@instance

# Install Hermes
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# Run gateway
hermes gateway install  # as systemd service
hermes gateway start
```

### DigitalOcean Droplet

Same as AWS EC2. Use Ubuntu image.

### Railway

```bash
# Set environment variables in Railway dashboard
ANTHROPIC_API_KEY=sk-...
OPENROUTER_API_KEY=sk-or-...

# Start command
hermes gateway run
```

### Fly.io

```bash
fly launch
fly secrets set ANTHROPIC_API_KEY=sk-...
fly deploy

# Verify
fly logs
```

## SSH Deployment

Run Hermes on a remote server:

```bash
# SSH into server
ssh user@server

# Install Hermes
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# Configure for SSH backend
# On local machine:
hermes config set terminal.backend ssh
hermes config set terminal.ssh.host server-ip
hermes config set terminal.ssh.user user

# Or use SSH config:
hermes config set terminal.backend local  # run locally, connect to remote gateway
hermes config set gateway.remote https://server:18789
```

## Resource Planning

| Use Case | CPU | RAM | Disk |
|----------|-----|-----|------|
| Chat only | 1 core | 1 GB | 5 GB |
| With tools | 2 cores | 2 GB | 10 GB |
| Heavy coding | 4 cores | 4 GB | 20 GB |
| Docker container | 2 cores | 2 GB | 10 GB |

## References

Structured reference docs:

- [Service Config](references/service-config.md) — Systemd/LaunchD setup
- [Cloud Deployment](references/cloud-deployment.md) — AWS, Railway, Fly.io
- [Android Tuning](references/android-tuning.md) — Termux optimization

Related skills:

- `hermes-install/` — installation for all platforms
- `hermes-gateway/` — deployment patterns
- `hermes-config/` — performance tuning
