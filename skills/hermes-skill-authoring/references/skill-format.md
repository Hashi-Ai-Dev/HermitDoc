# SKILL.md Format Reference

Complete specification for authoring Hermes skills.

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