# HermitDoc Changelog

All notable changes to HermitDoc are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.1.1] - 2026-05-27

### Changed

- CHANGELOG.md: corrected skill list — `hermes-skills`, `hermes-delegation`, `hermes-memory`, `hermes-logging`, `hermes-gateway` **do not** have reference docs (only 10 of 22 skills do)

## [1.1.0] - 2026-05-27

### Added

- **Structured reference docs** — 30 reference documents across 10 skills (`hermes-cli`, `hermes-concepts`, `hermes-config`, `hermes-cron`, `hermes-install`, `hermes-platforms`, `hermes-security`, `hermes-skill-authoring`, `hermes-tools`, `hermes-troubleshooting`)
- **common-pitfalls.md expanded** from 7 to 12 pitfalls
- **prerequisites.md expanded** from 19 to ~80 lines

### Changed

- README version badge updated: `v1.0.1` → `v1.1.0`
- HERMITDOC_MANIFEST.json: `hermitdoc_version` `v1.0.4` → `v1.1.0`; `reference_docs` `300` → `30`
- Brand assets refreshed: dark minimal theme, black background (#0a0a0a), platinum text (#c0c0c0), white accents

### Fixed

- **ComComma typo** → `Comma` in `hermes-cli/SKILL.md`
- **CHANGELOG.md** double `## ##` prefix on `[1.0.4]` entry corrected

---

## [1.0.4] - 2026-05-21

### Changed

- All 23 skills: `hermes_version` frontmatter bumped to `v2026.5.16`
- `hermes-channels`: LINE and SimpleX Chat added to supported platforms
- `hermes-tools`: `--platform` flag documented for `tools list/disable/enable`
- HERMITDOC_MANIFEST.json `hermitdoc_version` updated to `v1.0.4`
