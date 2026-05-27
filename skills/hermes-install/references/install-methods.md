# Installation Methods Reference

Quick reference for all platform installation methods.

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