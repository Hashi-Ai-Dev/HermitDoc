# HermitDoc v1.1.0

**Release Date:** 2026-05-27
**Repository:** https://github.com/Hashi-Ai-Dev/HermitDoc

---

## What's New

**HermitDoc `v1.1.0`** — structured reference docs overhaul, quality patches, and brand refresh.

This release introduces a new reference docs structure across all 23 skills, expands documentation depth, removes internal-only content from the public repo, and refreshes brand assets to a clean dark theme.

> **Tracks Hermes Agent:** `v2026.5.16`
> **Skills:** 23
> **Reference docs:** 30 (structured, expanded)

### Structured Reference Docs

Every skill now ships with dedicated `references/` subdirectories containing deep-dive documentation:
- `hermes-cli`: CLI reference + slash commands reference
- `hermes-skills`: skill management, publishing, browsing, auditing
- `hermes-config`: all config keys organized by category
- `hermes-delegation`: delegation config, batch patterns, toolsets
- `hermes-memory`: memory providers, session_search, user profiles
- `hermes-cron`: scheduling formats, delivery targets, script hooks, workdir injection
- `hermes-troubleshooting`: diagnostic flows, doctor, status, logs
- `hermes-logging`: log levels, filtering, rotation
- `hermes-gateway`: gateway setup, migration, service management
- `hermes-install`: prerequisites, all-platform guides, Docker

Each reference doc is embedded in its skill's `## References` section and also available as standalone files in `skills/<name>/references/`.

### Improvements

- **common-pitfalls.md expanded** from 7 to 12 documented pitfalls — new entries cover frontmatter `triggers` key (forbidden), uppercase skill names, description length limits (>1024 chars), UTF-8 BOM stripping, invalid category values, duplicate manifest entries, and bad reference paths
- **prerequisites.md expanded** from 19 to ~80 lines — new content includes system requirements table, provider API key comparison table, environment pre-checks (curl, python, git, hermes version), post-install verification steps, Docker-specific notes with resource flags, network/firewall requirements, and clean uninstall steps
- **Brand assets refreshed** — new dark minimal OG banner (16:9) and square badge (1:1) with black background (#0a0a0a), platinum text (#c0c0c0), white accents. No version numbers in filenames
- **README version badge** updated to `v1.1.0`
- **HERMITDOC_MANIFEST.json** — `hermitdoc_version` corrected to `v1.1.0`, `reference_docs` corrected from 300 to 30

### Bug Fixes

- **ComComma typo** in `hermes-cli/SKILL.md` global flags → corrected to `Comma-separated`
- **CHANGELOG.md** — fixed double `## ##` prefix on `[1.0.4]` entry (now correctly `## [1.0.4]`)
- **Internal docs removed** — `feature/1.1.0-audit-log.md` and `feature/1.1.0-benchmarks.md` deleted from public repo (internal-only policy)

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