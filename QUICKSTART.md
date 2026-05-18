# HermitDoc Quickstart (10 minutes)

Get HermitDoc running and answer your first Hermes question in under 10 minutes.

---

## Prerequisites

Before starting, verify you have:
- [ ] Hermes Agent installed
- [ ] `hermes doctor` passes (run it now)
- [ ] At least one model provider configured (`hermes model`)

If you haven't installed Hermes yet:
```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
hermes setup
```

---

## Step 1 — Choose Your Install Mode

| | Mode 1 — Persistent Agent | Mode 2 — Skills Only |
|---|---|---|
| Best for | Dedicated system doctor | Quick help in your existing agent |
| Creates new agent? | ✅ Yes | ❌ No |
| Separate identity? | ✅ Yes ("HermitDoc") | ❌ Your agent keeps its identity |

**Recommendation:** Start with **Mode 2 — Skills Only** unless you specifically want a dedicated HermitDoc agent.

---

## Step 2 — Install HermitDoc

### Mode 2 — Skills Only (Recommended)

```bash
# Clone the HermitDoc repo
git clone https://github.com/Hashi-Ai-Dev/HermitDoc.git /tmp/hermitdoc

# Copy skills to your Hermes skills directory
cp -r /tmp/hermitdoc/skills/* ~/.hermes/skills/

# Verify installation
hermes skills list | grep -i hermit
```

That's it. Start a new session (`/reset`) and ask your first question.

### Mode 1 — Persistent Agent

Follow the full guide at [AGENT_INSTALL.md](./AGENT_INSTALL.md).

---

## Step 3 — Ask Your First Question

Start a new session and try:

```
How do I configure Discord as a channel?
```

```
What's the difference between profiles and default config?
```

```
Help me set up a cron job that runs every morning
```

```
How do I create a reusable skill?
```

HermitDoc routes to the right skill and gives you a precise, grounded answer with exact commands.

---

## Common First Tasks

### Set up Discord
```
@your-agent How do I set up Discord as a messaging channel?
```
Follow the steps in `hermes-channels` — you'll need a bot token from the Discord Developer Portal.

### Configure OpenRouter
```
@your-agent How do I set up OpenRouter as a model provider?
```
You'll need an `OPENROUTER_API_KEY` in your `~/.hermes/.env`.

### Create a skill
```
@your-agent Help me create a skill for [your use case]
```
See `hermes-skill-authoring` for the full format guide.

### Schedule a cron job
```
@your-agent How do I schedule a daily report?
```
See `hermes-cron` for delivery targets (Discord, Telegram, local file).

---

## Skill Tree Overview

| Category | Skills |
|----------|--------|
| **Core** | `hermes-master`, `hermes-config`, `hermes-skills`, `hermes-delegation`, `hermes-memory` |
| **Operations** | `hermes-cron`, `hermes-troubleshooting`, `hermes-logging`, `hermes-security`, `hermes-hooks` |
| **Channels** | `hermes-channels`, `hermes-gateway`, `hermes-mcp`, `hermes-platforms`, `hermes-install` |
| **Tools** | `hermes-voice`, `hermes-providers`, `hermes-tools`, `hermes-cli` |
| **Concepts** | `hermes-soul`, `hermes-concepts`, `hermes-skill-authoring` |

---

## Pro Tips

1. **Restart after new skills** — Use `/reset` to pick up newly installed skills
2. **Use the master skill** — `hermes-master` routes to the right skill automatically
3. **Check examples/** — Ready-to-use JSON configs for common setups
4. **Run `hermes doctor`** — If something feels off, doctor often fixes it
5. **Contribute back** — Found a gap? Add a skill! See [CONTRIBUTING.md](./CONTRIBUTING.md)

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Skills not showing up | Restart the session: `/reset` |
| Config changes not applying | Some require a new session |
| Doctor failing | Fix errors first: `hermes doctor --fix` |
| Command not found | Check Hermes is in your PATH: `which hermes` |

Still stuck? → [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) or open an issue.

---

## Next Steps

- [ ] [AGENT_INSTALL.md](./AGENT_INSTALL.md) — if you want a dedicated HermitDoc agent
- [ ] [CONTRIBUTING.md](./CONTRIBUTING.md) — want to add a skill or fix a doc?
- [ ] [examples/](./examples/) — ready-to-use configs for common setups