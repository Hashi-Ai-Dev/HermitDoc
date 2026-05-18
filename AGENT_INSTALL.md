# Install HermitDoc as a Persistent Agent

Create a dedicated, persistent HermitDoc agent with its own workspace and identity. Use this when you want a standalone Hermes system doctor that runs continuously and can be addressed directly.

---

## Which mode is this?

**Mode 1 — Persistent Agent** creates a new named Hermes agent (`hermit-doc` or a name you choose) with its own workspace directory, routing bindings, and HermitDoc skill stack. The agent is fully independent of your existing setup.

For a lighter alternative where no new agent is created, see [SKILLS_INSTALL.md](./SKILLS_INSTALL.md) (Mode 2 — Skills Only).

> [!NOTE]
> Hermes Agent does not have a native multi-agent system like OpenClaw. Mode 1 creates a separate Hermes *process* with its own config profile, not a sub-agent within a single process. Consider whether Mode 2 (skills-only) might be simpler for your use case.

---

## Prerequisites

- Hermes Agent installed (`curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash`)
- A model provider already configured (`hermes doctor` passes)
- Git installed (to clone the repo)

---

## Step 1 — Create a Profile for HermitDoc

Hermes uses profiles for isolated configurations. Create a dedicated profile:

```bash
# Create the HermitDoc profile (cloned from default)
hermes profile create hermitdoc --clone-from default

# Set it as active
hermes profile use hermitdoc
```

Verify:
```bash
hermes profile show hermitdoc
```

---

## Step 2 — Install HermitDoc Skills

```bash
# Clone the HermitDoc repo
git clone https://github.com/Hashi-Ai-Dev/hermitdoc.git /tmp/hermitdoc

# Stable install (recommended for production):
cd /tmp/hermitdoc && git checkout v1.0.0

# Copy skills into the profile's skills directory
cp -r /tmp/hermitdoc/skills/* ~/.hermes/profiles/hermitdoc/skills/
```

> [!NOTE]
> The skills directory path depends on your Hermes version and profile configuration. Check `hermes config path` to find the active config location.

**Set the agent persona** — copy the HermitDoc SOUL.md as the profile's persona file:

```bash
# If your profile uses SOUL.md for persona:
cp /tmp/hermitdoc/agent-template/SOUL.md ~/.hermes/profiles/hermitdoc/SOUL.md

# Or set via CLI if available:
hermes personality set hermitdoc
```

Verify skills are loaded:
```bash
hermes skills list | grep -i hermit
```

---

## Step 3 — Configure Channel Bindings (Optional)

Route a channel to the HermitDoc profile so it can receive messages:

```bash
# Start the gateway with the HermitDoc profile
hermes gateway run --profile hermitdoc

# In a separate terminal, set the home channel once connected:
/sethome

# Or configure via config.yaml in the profile:
# channel_directory.json or gateway config for the profile
```

For channel-specific setup, see `hermes-channels` and `hermes-gateway` skills.

---

## Step 4 — Set the HermitDoc Identity (Optional)

If you want HermitDoc to have a distinct identity when responding:

```bash
# Edit the SOUL.md in the profile
nano ~/.hermes/profiles/hermitdoc/SOUL.md

# Or use the personality system
hermes personality set hermitdoc
```

---

## Step 5 — Smoke Test

```bash
# Check health
hermes doctor

# Start a chat session with the HermitDoc profile
hermes chat --profile hermitdoc
```

Then ask:
```
How do I configure a Discord channel?
```

HermitDoc should route to `hermes-channels` and return a precise, grounded answer.

---

## Using HermitDoc

Once running, address the HermitDoc profile in your configured channels:

```
@hermitdoc How do I configure memory?
@hermitdoc What's wrong with my config?
@hermitdoc Help me set up MCP
```

---

## Updating HermitDoc

**Stable release update:**

```bash
cd /tmp/hermitdoc && git fetch --tags
git checkout v1.0.0
cp -r /tmp/hermitdoc/skills/* ~/.hermes/profiles/hermitdoc/skills/
# If SOUL.md was updated:
cp /tmp/hermitdoc/agent-template/SOUL.md ~/.hermes/profiles/hermitdoc/SOUL.md
hermes skills check --profile hermitdoc
```

**Bleeding-edge update:**

```bash
cd /tmp/hermitdoc && git checkout master && git pull
cp -r /tmp/hermitdoc/skills/* ~/.hermes/profiles/hermitdoc/skills/
cp /tmp/hermitdoc/agent-template/SOUL.md ~/.hermes/profiles/hermitdoc/SOUL.md
hermes skills check --profile hermitdoc
```

---

## Uninstalling Mode 1

```bash
# Remove the HermitDoc profile (back up config first!)
hermes profile delete hermitdoc

# Or just remove the skills:
rm -rf ~/.hermes/profiles/hermitdoc/skills/hermes-*

# Optionally remove the cloned repo
rm -rf /tmp/hermitdoc
```

---

## Troubleshooting

**Skills not visible to the profile?**
```bash
hermes skills list --profile hermitdoc
hermes skills check --profile hermitdoc
```

**Profile not receiving messages?**
- Check the gateway is running: `hermes gateway status`
- Verify the channel is configured in the profile's config
- Check `hermes doctor` for the profile

**Need to start over?**
```bash
hermes profile delete hermitdoc
# Then re-run from Step 1
```