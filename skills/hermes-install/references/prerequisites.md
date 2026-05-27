# Prerequisites Reference

Software and service requirements before installing Hermes Agent.

## System Requirements

| Component | Minimum | Recommended | Notes |
|-----------|---------|-------------|-------|
| **OS** | Linux (glibc 2.31+), macOS 12+, Windows 10+ (WSL2) | Ubuntu 22.04+, macOS 14+ | Windows requires WSL2 for full feature support |
| **RAM** | 4 GB | 8 GB+ | 4 GB is sufficient for skills-only mode; 8 GB recommended for full agent with memory providers |
| **Disk** | 2 GB free | 10 GB+ free | Hermes home directory (`~/.hermes/`) grows with sessions, memory providers, and logs |
| **CPU** | x86_64 / ARM64 | x86_64 / ARM64 | ARM64 (Apple Silicon, ARM servers) supported natively |
| **Python** | 3.10+ | 3.11+ | Required for Python-based tools and skill hooks |
| **Node.js** | 18+ | 20 LTS | Required for MCP server features and some skill integrations |
| **Git** | 2.30+ | latest | Required for cloning and updating HermitDoc skills |

## Provider API Keys

You need at least one model provider API key before Hermes can function. Below is a comparison of supported providers:

| Provider | Auth Method | API Key Format | Notes |
|----------|-------------|----------------|-------|
| **MiniMax** | API Key | `sk-xxxxxxxx` | Set via `hermes config set model.provider minimax` |
| **OpenAI** | API Key | `sk-xxxxxxxx` | Supports GPT-4o, GPT-4o-mini, o1, o3 family |
| **Anthropic** | API Key | `sk-ant-xxxxxxxx` | Supports Claude 3.5, 3.7, 4 family; requires key from console.anthropic.com |
| **xAI / Grok** | OAuth (Supergrok) | OAuth flow | No explicit API key needed — OAuth handles auth; requires SuperGrok subscription |
| **OpenRouter** | API Key | `sk-or-v1-xxxxxxxx` | Aggregates 100+ models; supports model routing and fallbacks |
| **DeepSeek** | API Key | `sk-xxxxxxxx` | V3 and R1 models; cost-effective reasoning |
| **Google (Gemini)** | API Key | `AIzaSyxxxxxxxx` | Gemini 2.0 Flash, 2.5 Pro; via Google AI Studio |
| **Groq** | API Key | `gsk_xxxxxxxx` | Fast inference for Llama, Mixtral; low latency |
| **Custom / OpenAI-compatible** | API Key + base URL | `sk-xxxxxxxx` + `https://...` | Use `hermes model add-custom` for local proxies, LM Studio, vLLM endpoints |

### Setting Up Provider Credentials

```bash
# Interactive setup wizard (recommended for first-time)
hermes setup

# Manual config edit
hermes config edit

# Direct config set
hermes config set model.provider openrouter
hermes config set openrouter.api_key sk-or-v1-xxxxxxxx

# OAuth login (for Nous Portal, SuperGrok)
hermes login --provider nous
hermes login --provider openai-codex
```

## Environment Pre-Checks

Run these commands before installing to ensure your environment is ready:

```bash
# Verify git is installed and working
git --version
# Expected: git version 2.40.0 or higher

# Verify Python version (3.10+ required)
python3 --version
# Expected: Python 3.10.0 or higher

# Verify curl is available (for network checks)
curl --version
# Expected: 7.85.0 or higher

# Verify hermes is installed (if upgrading from older version)
hermes version
# Expected: Hermes v2026.5.16 or higher
```

## Post-Install Verification

After installing HermitDoc, verify everything is working:

```bash
# Step 1: Reload Hermes to pick up new skills
/reset

# Step 2: Verify HermitDoc skills are loaded
hermes skills list | grep -i hermit

# Expected output should include:
// hermitdoc-onboarding
// hermes-master
// hermes-cli
// hermes-config
// ... (all 23 skills)

# Step 3: Run doctor to check system health
hermes doctor

# Step 4: Check config
hermes config show

# Step 5: Verify model provider is configured
hermes model
```

Expected `hermes doctor` output should show all checks passing:
- ✅ Config file found
- ✅ Provider credentials present
- ✅ Memory provider configured (or built-in)
- ✅ Gateway ready (or not needed for skills-only mode)

## Docker-Specific Notes

If running Hermes inside Docker:

```bash
# Ensure Docker has sufficient resources
docker run --rm -it \
  --cpus=2 \
  --memory=4g \
  --publish 127.0.0.1:3000:3000 \
  nousresearch/hermes-agent:latest

# For persistent config, mount volumes
docker run --rm -it \
  --cpus=2 \
  --memory=4g \
  --volume ~/.hermes:/app/.hermes \
  --publish 127.0.0.1:3000:3000 \
  nousresearch/hermes-agent:latest
```

Docker considerations:
- Hermes home lives at `/app/.hermes/` inside the container
- Mount `~/.hermes/` from host for persistent config and sessions
- Gateway features require `--network host` or port forwarding
-声音 (TTS/STT) may require `--device /dev/snd` for audio hardware access

## Network & Firewall Requirements

Ensure outbound access to:
- `api.minimaxi.chat` (MiniMax API)
- `api.openai.com` (OpenAI API)
- `api.anthropic.com` (Anthropic API)
- `api.openrouter.ai` (OpenRouter API)
- `api.x.ai` (xAI/Grok API)
- `console.anthropic.com` (OAuth flow)

If behind a corporate firewall, set proxy via environment:
```bash
export HTTP_PROXY=http://proxy.company.com:8080
export HTTPS_PROXY=http://proxy.company.com:8080
hermes doctor
```

## Uninstall / Clean Slate

To remove Hermes completely:
```bash
hermes uninstall     # Removes Hermes binary and scripts
rm -rf ~/.hermes/    # Removes all config, sessions, memory, skills
rm -rf ~/.config/hermes-agent/  # Additional config location
```

To reset HermitDoc skills only (keep Hermes and config):
```bash
hermes skills uninstall hermitdoc-onboarding
# then re-clone and re-copy skills
```