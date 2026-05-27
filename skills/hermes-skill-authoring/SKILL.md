---
name: hermes-skill-authoring
description: "Use when creating new Hermes skills, writing SKILL.md, or contributing to HermitDoc. Covers: SKILL.md format, frontmatter requirements, size limits, directory structure, peer matching, validation, references, templates, publishing. Triggers on: skill authoring, create skill, SKILL.md format, frontmatter, skill structure, peer matching."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [skill-authoring, SKILL.md, frontmatter, validation, contributing]
    related_skills: [hermes-skills, hermes-master]
    hermes_version: "v2026.5.16"
---

# Hermes Skill Authoring Guide

Complete guide to authoring Hermes skills that match project conventions.

## Overview

Skills are reusable, persisted procedures. They store:
- When to use (triggers)
- Step-by-step workflows
- Pitfalls and verification steps
- Reference docs and examples

## Required Frontmatter

Every SKILL.md must have:

```yaml
---
name: my-skill-name               # lowercase, hyphens, ≤64 chars
description: "Use when <trigger>. <one-line behavior>. Triggers on: <phrases>."
version: 1.0.0
author: <your-name>
license: MIT
metadata:
  hermes:
    tags: [short, descriptive, tags]
    related_skills: [other-skill, another-skill]
---
```

**Required fields:**
- `name` — lowercase, hyphens, ≤64 chars
- `description` — ≤1024 chars, starts with "Use when..."
- Body content — non-empty after frontmatter

**Recommended fields:**
- `version` — SemVer (e.g., `1.0.0`)
- `author` — your name or GitHub handle
- `license` — MIT recommended
- `metadata.hermes.tags` — descriptive tags
- `metadata.hermes.related_skills` — links to related skills

## Size Limits

| Field | Limit |
|-------|-------|
| Description | ≤ 1024 chars |
| Full SKILL.md | ≤ 100,000 chars |

Peer skills in the repo are 8-15KB. Aim for that range. If pushing past 20KB, split into `references/*.md`.

## Directory Structure

```
skills/<category>/<skill-name>/
├── SKILL.md                      # Main skill file (required)
├── references/                   # Deep-dive docs (optional)
│   ├── topic1.md
│   └── topic2.md
├── templates/                    # Template files (optional)
│   └── template.yaml
└── scripts/                      # Utility scripts (optional)
    └── validate.sh
```

## Available Categories

| Category | Use for |
|----------|---------|
| `autonomous-ai-agents` | Claude Code, Codex, Hermes config |
| `creative` | Art, music, design, video |
| `data-science` | Jupyter, analytics, ML |
| `devops` | Cron, webhooks, Kanban |
| `email` | Gmail, SMTP |
| `gaming` | Game automation |
| `github` | PRs, issues, repos |
| `mcp` | MCP server integration |
| `media` | Spotify, YouTube, images |
| `mlops` | Fine-tuning, serving, benchmarks |
| `note-taking` | Obsidian, Notion |
| `productivity` | Calendars, docs, spreadsheets |
| `research` | arXiv, papers, search |
| `smart-home` | Home automation |
| `social-media` | Twitter/X, posting |
| `software-development` | Debugging, testing, planning |

For HermitDoc, skills go under `hermitdoc/skills/<category>/`.

## Peer-Matched Structure

Every skill follows this pattern:

```markdown
---
name: example-skill
description: "Use when <trigger>. <one-line behavior>. Triggers on: <phrases>."
version: 1.0.0
author: Your Name
license: MIT
metadata:
  hermes:
    tags: [tag1, tag2, tag3]
    related_skills: [other-skill]
---

# Skill Title

## Overview
One or two paragraphs: what it does and why it matters.

## When to Use
- Bulleted triggers
- "Don't use for:" counter-triggers

## <Topic sections>
- Quick-reference tables
- Code blocks with exact commands
- Hermes-specific patterns

## Common Pitfalls
Numbered list of mistakes and their fixes.

## Verification Checklist
- [ ] Checkbox list of post-action verifications
```

Not every section is mandatory, but `Overview` + `When to Use` + actionable body + pitfalls are the minimum.

## Description Format

Descriptions must:
1. Start with "Use when..."
2. Describe the trigger class, not one specific task
3. Embed triggers inline (not in separate frontmatter)
4. Be ≤ 1024 characters

**Good:**
```
Use when configuring model providers, API keys, or model selection. 
Covers: OpenRouter, Anthropic, DeepSeek, Gemini, Ollama, Groq, 
Together, HuggingFace, and 20+ providers. Provider config, auth setup, 
model routing, credential pools, failover.
Triggers on: provider, model, API key, openrouter, anthropic, deepseek, gemini.
```

**Bad:**
```
Configure models.
```

## Workflow

1. **Survey peers** in target category
2. **Draft** with `write_file`
3. **Validate** with the validator script
4. **Commit** on your branch
5. **PR** to HermitDoc

### Validator Script

```python
import yaml, re, pathlib
content = pathlib.Path("skills/<category>/<name>/SKILL.md").read_text()
assert content.startswith("---"), "Must start with ---"
m = re.search(r'\n---\s*\n', content[3:])
fm = yaml.safe_load(content[3:m.start()+3])
assert "name" in fm and "description" in fm
assert len(fm["description"]) <= 1024
assert len(content) <= 100_000
print("✅ Valid!")
```

## Validation Checklist

- [ ] File starts at byte 0 with `---`
- [ ] `name`, `description`, `version`, `author`, `license`, `metadata.hermes.{tags, related_skills}` all present
- [ ] Name ≤ 64 chars, lowercase + hyphens
- [ ] Description ≤ 1024 chars, starts with "Use when..."
- [ ] Total file ≤ 100,000 chars (aim for 8-15k)
- [ ] Structure: `# Title` → `## Overview` → `## When to Use` → body → `## Common Pitfalls` → `## Verification Checklist`
- [ ] `related_skills` references resolve (or are explicitly OK to be user-local)
- [ ] Git committed on your branch

## Common Pitfalls

1. **Using `skill_manage(action='create')` for in-repo skills.** It writes to `~/.hermes/skills/`, not the repo tree. Use `write_file` for repo contributions.

2. **Leading whitespace before `---`.** Validator checks `content.startswith("---")`. Any leading blank line or BOM fails.

3. **Description too generic.** "Use when debugging Python" > "Debug Python". Describe the trigger class.

4. **Forgetting author/license/metadata block.** Not validator-enforced, but every peer has it.

5. **Duplicating a peer.** Check existing skills in the category first.

6. **Expecting current session to see new skill.** The skill loader is cached at session start. Verify in a fresh session.

7. **Linking to skills that don't exist in-repo.** `related_skills: [some-user-local-skill]` works for you but breaks for others.

## Cross-Referencing

Use `related_skills` in frontmatter to link skills:

```yaml
metadata:
  hermes:
    related_skills: [hermes-config, hermes-cli, hermes-skills]
```

Within the body, reference other skills by name:
- "See `hermes-config/` for full reference"
- "Use `hermes-troubleshooting` for diagnosis flows"

## References

Structured reference docs:

- [SKILL.md Format](references/skill-format.md) — Frontmatter and format spec
- [Authoring Workflow](references/authoring-workflow.md) — Step-by-step process
- [Common Pitfalls](references/common-pitfalls.md) — Mistakes and fixes

Related skills:

- `hermes-skills/` — skill management
- `hermes-master/` — routing
- `hermes-concepts/` — architecture
- Official skill authoring docs: https://hermes-agent.nousresearch.com/docs/skill-system
