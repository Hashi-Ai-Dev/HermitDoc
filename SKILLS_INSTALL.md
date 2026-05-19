# Install HermitDoc Skills Only

Add HermitDoc's knowledge-base skills to your existing Hermes Agent without creating a new agent or profile. Use this when you want HermitDoc's expertise available in your current agent immediately.

---

## Which mode is this?

**Mode 2 — Skills Only** adds HermitDoc's 23 skills to your existing Hermes Agent. No new agent is created, no new profile needed. Your agent keeps its identity and config — HermitDoc skills are simply available alongside your existing setup.

For a dedicated standalone HermitDoc agent, see [AGENT_INSTALL.md](./AGENT_INSTALL.md) (Mode 1).

---

## Prerequisites

- Hermes Agent installed and working (`hermes doctor` passes)
- Git installed

---

## Step 1 — Clone HermitDoc

```bash
# Clone the HermitDoc repo
git clone https://github.com/Hashi-Ai-Dev/HermitDoc.git /tmp/hermitdoc

# Checkout the stable release (recommended)
cd /tmp/hermitdoc && git checkout v1.0.1
```

---

## Step 2 — Install the Skills

```bash
# Copy all skills to your Hermes skills directory
cp -r /tmp/hermitdoc/skills/* ~/.hermes/skills/
```

Verify:
```bash
hermes skills list | grep -i hermit
```

You should see all 23 HermitDoc skills listed.

---

## Step 3 — Restart Your Session

**Important:** Skills are loaded at session start. You must restart the session to pick up new skills.

```bash
# In an interactive chat session, type:
/reset

# Or start a new session:
hermes chat
```

---

## Step 4 — Verify It Works

Ask HermitDoc a question:

```
@your-agent How do I configure Discord as a channel?
@your-agent What's the difference between profiles and default config?
@your-agent Help me set up a cron job
@your-agent How do I create a skill?
@your-agent My hermes doctor is failing, help
```

HermitDoc routes to the right skill and returns a precise, grounded answer.

---

## How It Works

HermitDoc skills are organized under `~/.hermes/skills/`:

```
~/.hermes/skills/
├── hermes-master/          # Routing hub — always check this first
├── hermes-config/          # Config reference
├── hermes-skills/          # Skill management
├── hermes-delegation/      # Subagent patterns
├── hermes-memory/          # Memory and session search
├── hermes-cron/            # Scheduling
├── hermes-troubleshooting/  # Doctor and diagnostics
├── hermes-logging/         # Log management
├── hermes-security/         # Security settings
├── hermes-hooks/           # Shell hooks
├── hermes-channels/        # Messaging channels
├── hermes-gateway/          # Platform integrations
├── hermes-mcp/             # MCP server setup
├── hermes-platforms/       # Platform guides
├── hermes-install/         # Install guides
├── hermes-voice/           # TTS/STT
├── hermes-providers/        # Model providers
├── hermes-tools/           # Tool reference
├── hermes-cli/             # CLI commands
├── hermes-soul/            # SOUL.md authoring
├── hermes-concepts/         # Architecture concepts
├── hermes-skill-authoring/  # Skill creation guide
└── hermitdoc-onboarding/    # First-run guide
```

---

## Updating HermitDoc

```bash
# Pull the latest version
cd /tmp/hermitdoc && git pull

# Or switch to a specific release:
cd /tmp/hermitdoc && git checkout v1.0.1  # or v1.0.1, etc.

# Re-copy skills
cp -r /tmp/hermitdoc/skills/* ~/.hermes/skills/

# Restart session
/reset
```

Check for updates:
```bash
hermes skills check
```

---

## Uninstalling Mode 2

```bash
# Remove HermitDoc skills
rm -rf ~/.hermes/skills/hermes-master
rm -rf ~/.hermes/skills/hermes-config
rm -rf ~/.hermes/skills/hermes-skills
rm -rf ~/.hermes/skills/hermes-delegation
rm -rf ~/.hermes/skills/hermes-memory
rm -rf ~/.hermes/skills/hermes-cron
rm -rf ~/.hermes/skills/hermes-troubleshooting
rm -rf ~/.hermes/skills/hermes-logging
rm -rf ~/.hermes/skills/hermes-security
rm -rf ~/.hermes/skills/hermes-hooks
rm -rf ~/.hermes/skills/hermes-channels
rm -rf ~/.hermes/skills/hermes-gateway
rm -rf ~/.hermes/skills/hermes-mcp
rm -rf ~/.hermes/skills/hermes-platforms
rm -rf ~/.hermes/skills/hermes-install
rm -rf ~/.hermes/skills/hermes-voice
rm -rf ~/.hermes/skills/hermes-providers
rm -rf ~/.hermes/skills/hermes-tools
rm -rf ~/.hermes/skills/hermes-cli
rm -rf ~/.hermes/skills/hermes-soul
rm -rf ~/.hermes/skills/hermes-concepts
rm -rf ~/.hermes/skills/hermes-skill-authoring
rm -rf ~/.hermes/skills/hermitdoc-onboarding

# Clean up cloned repo
rm -rf /tmp/hermitdoc

# Restart session
/reset
```

---

## Troubleshooting

**Skills not appearing after install?**
```bash
hermes skills list | grep -i hermit
```
If empty, the copy failed. Re-run Step 2.

**Still not loading after copy?**
- You MUST restart the session: `/reset`
- Skills are cached at session start

**Want to install specific skills only?**
```bash
# Install individual skills
cp -r /tmp/hermitdoc/skills/hermes-config ~/.hermes/skills/
cp -r /tmp/hermitdoc/skills/hermes-skills ~/.hermes/skills/
```

**Need help?**
- Run `hermes doctor` to diagnose issues
- See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
- Open an issue at https://github.com/Hashi-Ai-Dev/HermitDoc/issues