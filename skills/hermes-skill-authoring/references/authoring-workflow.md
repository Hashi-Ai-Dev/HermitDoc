# Skill Authoring Workflow

Step-by-step process for creating Hermes skills.

## Workflow Overview

1. **Survey peers** in target category
2. **Draft** with `write_file`
3. **Validate** with the validator script
4. **Commit** on your branch
5. **PR** to HermitDoc

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

## Validator Script

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