---
name: hermes-install
description: "Use when installing or deploying Hermes Agent. Covers: Linux, macOS, WSL2, Windows (WSL), Android (Termux), Docker, cloud deployment, update, uninstall. Triggers on: install, install hermes, setup, deployment, docker, linux, macos, windows, wsl, termux."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [install, setup, deployment, docker, linux, macos, windows, wsl, termux]
    related_skills: [hermes-platforms, hermes-cli, hermes-config]
    hermes_version: "2026.x"
---

# Hermes Install Reference

Complete installation guide for all platforms and deployment methods.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

Then run:
```bash
hermes setup       # Interactive setup wizard
hermes doctor      # Verify installation
```

## Linux

### Install

```bash
# One-liner
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# Or manual
wget https://github.com/NousResearch/hermes-agent/releases/latest/download/hermes-linux-amd64
chmod +x hermes-linux-amd64
sudo mv hermes-linux-amd64 /usr/local/bin/hermes
```

### Verify

```bash
hermes --version
hermes doctor
```

## macOS

### Install

```bash
# Via curl
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# Via Homebrew (if available)
brew install hermes-agent

# Or manual
wget https://github.com/NousResearch/hermes-agent/releases/latest/download/hermes-macos-arm64
chmod +x hermes-macos-arm64
sudo mv hermes-macos-arm64 /usr/local/bin/hermes
```

### Apple Silicon (M1/M2)

Works natively. Use the arm64 binary or Homebrew.

## Windows (WSL2)

### Prerequisites

1. Enable WSL2 in Windows
2. Install a Linux distro (Ubuntu recommended)
3. Install Node.js in WSL: `curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -`

### Install in WSL

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

### Windows Terminal

Use Windows Terminal or PowerShell with WSL integration:
```powershell
wsl
hermes chat
```

## Android (Termux)

### Prerequisites

```bash
# Install Termux from F-Droid (not Google Play)
# Grant storage permission
termux-setup-storage
```

### Install

```bash
pkg update && pkg upgrade
pkg install git python nodejs
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

### Note

Memory is limited on Android. Use lightweight models.

## Docker

### Run Interactively

```bash
docker run -it \
  -v ~/.hermes:/root/.hermes \
  -v $(pwd):/workspace \
  ghcr.io/nousresearch/hermes-agent
```

### Run with Custom Config

```bash
docker run -d \
  --name hermes \
  -v ~/.hermes:/root/.hermes \
  -v /path/to/config:/root/.hermes/config.yaml \
  -p 18789:18789 \
  ghcr.io/nousresearch/hermes-agent hermes gateway run
```

### Docker Compose

```yaml
version: '3.8'
services:
  hermes:
    image: ghcr.io/nousresearch/hermes-agent
    volumes:
      - ~/.hermes:/root/.hermes
    ports:
      - "18789:18789"
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
    restart: unless-stopped
```

## Cloud Deployment

### Railway

1. Connect GitHub repo
2. Set build command: `npm install`
3. Set start command: `hermes gateway run`
4. Add environment variables

### Fly.io

```bash
fly launch
fly secrets set ANTHROPIC_API_KEY=sk-...
fly deploy
```

### DigitalOcean App Platform

1. Create from GitHub
2. Build command: `npm install`
3. Run command: `hermes gateway run`

### Vercel

Not recommended — Hermes is long-running, Vercel is stateless.

## Updating Hermes

```bash
# Update to latest
hermes update

# Or reinstall
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

## Uninstalling

```bash
# Remove Hermes
hermes uninstall

# Or manual
rm /usr/local/bin/hermes

# Remove config (optional)
# WARNING: This deletes all data
rm -rf ~/.hermes

# Remove from Docker
docker rm -f hermes
docker rmi ghcr.io/nousresearch/hermes-agent
```

## Prerequisites

Before installing, ensure you have:

- **Node.js** 18+ (for some features)
- **Python** 3.10+ (for Python tools)
- **Git** (for cloning and updates)
- **API keys** for your chosen model provider

## Post-Install Setup

```bash
hermes setup              # Interactive wizard
hermes model              # Select provider
hermes doctor             # Verify
```

## References

- `hermes-platforms/` — platform-specific details
- `hermes-config/` — initial configuration
- `hermes-channels/` — messaging platform setup
- Official install docs: https://hermes-agent.nousresearch.com/docs/getting-started
