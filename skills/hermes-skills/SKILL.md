---
name: hermes-skills
description: "Use when managing Hermes skills. Covers: hermes skills CLI (browse, search, install, inspect, list, check, update, audit, uninstall, reset, publish, snapshot, tap, config), skill installation from hub/GitHub/URL, skill enabling per platform, skill sources (tap). Triggers on: skill, skills, install skill, create skill, hermes skill."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [skills, skill-management, skill-hub, installation, sources]
    related_skills: [hermes-skill-authoring, hermes-cli]
    hermes_version: "v2026.5.16"
---

# Hermes Skills Reference

Skill management via `hermes skills` CLI.

## Skills CLI

```bash
hermes skills browse              # Browse all available skills (paginated, from hub)
hermes skills search QUERY       # Search skill registries
hermes skills install ID          # Install a skill (ID, URL, or GitHub ref)
hermes skills inspect ID         # Preview without installing
hermes skills list               # List installed skills
hermes skills check              # Check installed hub skills for updates
hermes skills update             # Update installed hub skills
hermes skills audit              # Re-scan installed hub skills
hermes skills uninstall NAME     # Remove a hub-installed skill
hermes skills reset NAME         # Reset a bundled skill (clears user-modified tracking)
hermes skills publish PATH       # Publish a skill to a registry
hermes skills snapshot           # Export/import skill configurations
hermes skills tap add REPO       # Add a GitHub repo as a skill source
hermes skills config             # Interactive enable/disable per platform
```

## Installing Skills

**From the hub:**
```bash
hermes skills install github-pr-workflow
hermes skills install https://example.com/skill/SKILL.md
```

**From HermitDoc:**
```bash
git clone https://github.com/Hashi-Ai-Dev/HermitDoc.git /tmp/hermitdoc
cp -r /tmp/hermitdoc/skills/* ~/.hermes/skills/
/reset
```

**From tap source:**
```bash
hermes skills tap add https://github.com/user/skill-repo
hermes skills install my-skill-from-tap
```

## Skill Sources (tap)

```bash
hermes skills tap add REPO      # Add a GitHub repo as skill source
# Then install from the tap:
hermes skills install my-skill
```

## Skill Configuration

```bash
# Enable/disable skills per platform
hermes skills config

# Interactive UI for per-platform skill toggling
```

## Skill Audit

```bash
hermes skills audit              # Re-scan all installed skills
hermes skills check              # Check hub skills for updates
hermes skills update             # Update all hub skills
```

## Skill Reset

```bash
hermes skills reset my-skill    # Reset a bundled skill to original state
# Clears 'user-modified' tracking so updates work again
```

## Publishing Skills

```bash
hermes skills publish path/to/skill
# Publish to configured registries
```

## Manual Install

```bash
cp -r /path/to/skill ~/.hermes/skills/
/reset
```

## Common Issues

**Skill not appearing after install:**
- Restart session: `/reset`
- Skills load at session start

**Can't find a skill:**
```bash
hermes skills search "keyword"
hermes skills browse
```

**Skill update not working:**
```bash
hermes skills reset my-skill
hermes skills update
```

## References

- `hermes-skill-authoring/` — skill creation guide
- `hermes-cli/` — full CLI reference
- `hermes-master/` — routing and overview
