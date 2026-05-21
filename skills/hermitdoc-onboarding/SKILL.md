---
name: hermitdoc-onboarding
description: "Use when first setting up HermitDoc, choosing an install mode, or needing a guided walkthrough. Provides step-by-step setup for both persistent agent and skills-only modes. Triggers on: hermitdoc setup, getting started, install guide, onboarding, first time, new user, how do i start."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [hermitdoc, onboarding, setup, getting-started, first-run]
    related_skills: [hermes-master, hermes-install, hermes-channels]
    hermes_version: "v2026.5.16"
---

# HermitDoc Onboarding

Welcome to HermitDoc — your Hermes Agent system doctor and configuration expert.

## Overview

HermitDoc knows the entire Hermes Agent system inside and out. It handles configuration, skill authoring, multi-agent delegation, channel setup, MCP integration, voice, security, and troubleshooting — with precision, not guesswork.

> [!NOTE]
> HermitDoc is a community project. It is **not affiliated with or endorsed by** Nous Research.

## Two Install Modes

HermitDoc supports two adoption paths:

| | Mode 1 — Persistent Agent | Mode 2 — Skills Only |
|---|---|---|
| **What it does** | Creates a dedicated HermitDoc agent with its own workspace | Adds HermitDoc skills to your existing agent |
| **Best for** | Serious ongoing maintenance, system doctor use | Quick Hermes help in an existing agent |
| **New agent created?** | ✅ Yes | ❌ No |
| **Separate identity?** | ✅ Yes | ❌ Your agent keeps its identity |
| **Guide** | [AGENT_INSTALL.md](./AGENT_INSTALL.md) | [SKILLS_INSTALL.md](./SKILLS_INSTALL.md) |

Not sure which to pick? Start with **Mode 2 — Skills Only** for the lightest path. Switch to Mode 1 if you want HermitDoc to have its own persistent workspace and identity.

## Quick Start Checklist

### Before you begin
- [ ] Hermes Agent installed (`curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash`)
- [ ] `hermes doctor` passes (run it now)
- [ ] At least one model provider configured (`hermes model`)

### Install HermitDoc (choose your mode)
- [ ] Follow [AGENT_INSTALL.md](./AGENT_INSTALL.md) **OR** [SKILLS_INSTALL.md](./SKILLS_INSTALL.md)

### Verify it works
- [ ] Run `hermes skills list | grep -i hermit` or `hermes skills check`
- [ ] Ask HermitDoc a question:
  ```
  @your-agent How do I configure HermitDoc for my setup?
  @your-agent What's the difference between profiles and default config?
  @your-agent Help me set up Discord as a channel
  ```

### Next steps
- [ ] Explore skills: `hermes skills browse` and filter for hermitdoc skills
- [ ] Read [QUICKSTART.md](./QUICKSTART.md) for common workflows
- [ ] Check [examples/](./examples/) for ready-to-use configurations

## Skill Tree Overview

HermitDoc organizes its knowledge across 5 areas:

**Core** — `hermes-master` (routing), `hermes-config`, `hermes-skills`, `hermes-delegation`
**Operations** — `hermes-cron`, `hermes-memory`, `hermes-troubleshooting`, `hermes-logging`, `hermes-security`, `hermes-hooks`
**Channels & Platforms** — `hermes-channels`, `hermes-gateway`, `hermes-mcp`, `hermes-platforms`, `hermes-install`
**Tools & Providers** — `hermes-voice`, `hermes-providers`, `hermes-tools`, `hermes-cli`
**Concepts & Help** — `hermes-soul`, `hermes-concepts`, `hermes-skill-authoring`

## Common First Tasks

1. **Configure a messaging channel** → `hermes-channels` (Discord, Telegram, Slack, etc.)
2. **Set up a model provider** → `hermes-providers` (OpenRouter, Anthropic, DeepSeek, etc.)
3. **Create a reusable skill** → `hermes-skill-authoring`
4. **Schedule a recurring task** → `hermes-cron`
5. **Debug an issue** → `hermes-troubleshooting`

## Operating Principles

- **Precision over speed** — Quote the schema, cite the docs, show the exact command
- **No hand-waving** — If not sure, say so and investigate
- **Show your work** — Command sequences make answers learnable
- **Community-minded** — Design for clarity and generalizability, not just your setup

## Getting Help

- Hermes docs: https://hermes-agent.nousresearch.com/docs/
- Hermes GitHub: https://github.com/NousResearch/hermes-agent
- HermitDoc GitHub: https://github.com/Hashi-Ai-Dev/HermitDoc
- Issues: https://github.com/Hashi-Ai-Dev/HermitDoc/issues

## Common Pitfalls

1. **Skills not loading after install** → Restart the session (`/reset`) — skills are loaded at session start
2. **Config changes not applying** → Some config changes require a new session; check `hermes doctor`
3. **Permission denied on gateway commands** → Ensure you're in the home channel or have pairing approved

## Verification Checklist

- [ ] `hermes doctor` passes
- [ ] HermitDoc skills visible via `hermes skills list`
- [ ] Test question answered successfully
- [ ] One common task completed (channel setup, cron job, skill creation)
