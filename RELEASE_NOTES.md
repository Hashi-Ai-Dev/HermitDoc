# HermitDoc v1.0.1

**Release Date:** 2026-05-19
**Repository:** https://github.com/Hashi-Ai-Dev/HermitDoc

---

## What's New

**HermitDoc `v1.0.1`** — patch release with version hygiene, repo audit fixes, and public-ready setup.

> **Tracks Hermes Agent:** `2026.x`
> **Skills:** 23

### Key Changes

- **Every skill carries `hermes_version`** in frontmatter metadata — each skill is tagged to the Hermes release it was verified against
- **`scripts/audit.sh`** now enforces `hermes_version` presence in all skills
- README reorganized: banner above fold, version/sync table, ClawDoc cross-reference
- MIT license + Hermes Agent `2026.x` badges added to README
- QUICKSTART now shows version + Hermes tracked version at a glance

### Fixes

- `HERMITDOC_MANIFEST.json` skill count corrected: `22` → `23`
- SECURITY.md scope section added
- CONTRIBUTING.md PR process now references `scripts/audit.sh` explicitly

### Security

- **`.github/CODEOWNERS`** added — all merges to `main` require maintainer approval, blocking prompt injection via malicious external PRs

---

## Install

### Skills Only (Recommended)

```bash
git clone https://github.com/Hashi-Ai-Dev/HermitDoc.git /tmp/hermitdoc
cp -r /tmp/hermitdoc/skills/* ~/.hermes/skills/
```

Then: `/reset`

### AI-Agent Install

```
"Install HermitDoc from https://github.com/Hashi-Ai-Dev/HermitDoc"
```

---

## Use It

```
@your-agent How do I configure Discord?
@your-agent Help me set up MCP for GitHub
@your-agent What's the real hermes cron create syntax?
@your-agent How do I create a skill?
```

---

## For Agents

HermitDoc is primarily designed for AI agents running on Hermes. Every answer is grounded in verified CLI commands and real config keys — no guesswork, no fabricated documentation.

---

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for skill format guide, validation, and contribution workflow.

---

## Versioning

HermitDoc uses SemVer:
- **Major** (X.0.0): Big Hermes version updates, new skill categories
- **Minor** (0.X.0): New skills, significant content updates
- **Patch** (0.0.X): Bug fixes, CLI corrections, doc updates, sync with Hermes releases

---

## Community

- GitHub: https://github.com/Hashi-Ai-Dev/HermitDoc
- Hermes Docs: https://hermes-agent.nousresearch.com/docs/
- Hermes GitHub: https://github.com/NousResearch/hermes-agent
- Issues: https://github.com/Hashi-Ai-Dev/HermitDoc/issues