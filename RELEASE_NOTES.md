# HermitDoc v1.0.0

**Release Date:** 2026-05-18
**Repository:** https://github.com/Hashi-Ai-Dev/hermitdoc

---

## What's New

HermitDoc is a comprehensive knowledge-base agent for Hermes Agent — a community project (not affiliated with Nous Research) that provides verified, grounded answers for all Hermes configuration and operation questions.

### 23 Skills

| Category | Skills |
|----------|--------|
| **Core** | hermes-master, hermes-config, hermes-skills, hermes-delegation, hermes-memory |
| **Operations** | hermes-cron, hermes-troubleshooting, hermes-logging, hermes-security, hermes-hooks |
| **Channels** | hermes-channels, hermes-gateway, hermes-mcp, hermes-platforms, hermes-install |
| **Tools** | hermes-voice, hermes-providers, hermes-tools, hermes-cli |
| **Concepts** | hermes-soul, hermes-concepts, hermes-skill-authoring, hermitdoc-onboarding |

### Key Features

- **All CLI commands verified** against actual Hermes CLI
- **All config keys verified** against real config.yaml
- **Dual-mode install**: persistent agent (profile) or skills-only
- **Ready-to-use examples**: Discord, Telegram, OpenRouter, cron, voice, MCP, and more
- **Pre-release audit script** validates all 23 skills
- **Machine-readable manifest** (HERMITDOC_MANIFEST.json)

---

## Install

### Skills Only (Recommended)

```bash
git clone https://github.com/Hashi-Ai-Dev/hermitdoc.git /tmp/hermitdoc
cp -r /tmp/hermitdoc/skills/* ~/.hermes/skills/
```

Then restart: `/reset`

### AI-Agent Install

```
"Install HermitDoc from https://github.com/Hashi-Ai-Dev/hermitdoc"
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

- GitHub: https://github.com/Hashi-Ai-Dev/hermitdoc
- Hermes Docs: https://hermes-agent.nousresearch.com/docs/
- Hermes GitHub: https://github.com/NousResearch/hermes-agent
- Issues: https://github.com/Hashi-Ai-Dev/hermitdoc/issues