# Contributing to HermitDoc

Thank you for your interest in contributing to HermitDoc!

HermitDoc is a community-maintained knowledge-base for Hermes Agent. We welcome contributions at all levels — new skills, reference docs, examples, bug fixes, and improvements to existing content.

---

## Code of Conduct

By participating, you agree to uphold our community standards:
- **Be respectful** —Disagree professionally, attack ideas not people
- **Be inclusive** — Welcome newcomers and diverse perspectives
- **Be helpful** — Share knowledge freely, lift others up
- **Be constructive** — Offer solutions, not just criticism

Violations may result in removal from the project.

Full policy: [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)

---

## Ways to Contribute

### 🆕 New Skills
Create a new skill under `skills/<category>/<skill-name>/SKILL.md`. See [hermes-skill-authoring](./skills/hermes-skill-authoring/SKILL.md) for the format guide.

### 📚 Reference Docs
Add deep-dive documentation in `skills/<skill-name>/references/`. Reference docs should be focused, accurate, and complement the skill body.

### 🧪 Examples
Add example configurations in `examples/`. Each example should include a `*.json` config and a `*.md` description explaining what it does and when to use it.

### 🐛 Bug Fixes
Fix errors in existing skills or docs. Every fix should include a verification step.

### 📖 Improvements
Improve clarity, add missing triggers, fill gaps in coverage. No contribution is too small.

---

## Getting Started

### Prerequisites
- Hermes Agent installed (`hermes doctor` passes)
- Git basic knowledge
- A GitHub account

### Process

1. **Fork the repo** — https://github.com/Hashi-Ai-Dev/HermitDoc/fork

2. **Clone your fork:**
   ```bash
   git clone https://github.com/<your-user>/hermitdoc.git
   cd hermitdoc
   ```

3. **Create a branch:**
   ```bash
   git checkout -b skill/<new-skill-name>
   # or
   git checkout -b fix/<descriptive-name>
   # or
   git checkout -b docs/<area-being-improved>
   ```

4. **Make your changes** — follow the skill format below

5. **Test locally** — validate your SKILL.md:
   ```python
   import yaml, re, pathlib
   content = pathlib.Path("skills/<category>/<name>/SKILL.md").read_text()
   assert content.startswith("---")
   m = re.search(r'\n---\s*\n', content[3:])
   fm = yaml.safe_load(content[3:m.start()+3])
   assert "name" in fm and "description" in fm
   assert len(fm["description"]) <= 1024
   assert len(content) <= 100000
   ```

6. **Commit:**
   ```bash
   git add skills/<category>/<name>/
   git commit -m "feat(skills): add <skill-name> for <purpose>"
   ```

7. **Push and PR:**
   ```bash
   git push origin skill/<new-skill-name>
   # Then open a PR at https://github.com/Hashi-Ai-Dev/HermitDoc/pulls
   ```

---

## Skill Format

Every skill must follow this structure:

```yaml
---
name: <skill-name>          # lowercase, hyphens, ≤64 chars
description: "Use when <trigger>. <one-line behavior>. Triggers on: <trigger phrases>."
version: 1.0.0
author: <your-name>
license: MIT
metadata:
  hermes:
    tags: [short, descriptive, tags]
    related_skills: [other-skill, another-skill]
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

**Required frontmatter fields:** `name`, `description` (≤1024 chars), `version`, `author`, `license`, `metadata.hermes.{tags, related_skills}`.

**File location:** `skills/<category>/<skill-name>/SKILL.md`

**Target size:** 8-15k chars (aim for peer-comparable skills). If pushing past 20k, split into `references/*.md`.

---

## Directory Structure

```
hermitdoc/
├── README.md                    # Project overview + skill tree
├── QUICKSTART.md                # 10-minute getting started guide
├── AGENT_INSTALL.md             # Mode 1: persistent agent install
├── SKILLS_INSTALL.md            # Mode 2: skills-only install
├── CONTRIBUTING.md              # This file
├── CODE_OF_CONDUCT.md           # Community standards
├── SECURITY.md                  # Security policy
├── LICENSE                      # MIT license
├── HERMITDOC_MANIFEST.json      # Machine-readable index
├── skills/                      # All HermitDoc skills
│   ├── hermes-master/
│   ├── hermes-config/
│   ├── hermes-skills/
│   ├── hermitdoc-onboarding/
│   └── ...
├── agent-template/              # SOUL.md, AGENTS.md templates
├── examples/                    # Ready-to-use JSON configs
└── scripts/                     # Utility scripts
```

---

## Branch Naming

| Type | Pattern | Example |
|------|---------|---------|
| New skill | `skill/<name>` | `skill/hermes-profiles` |
| Bug fix | `fix/<description>` | `fix/discord-channel-routing` |
| Docs | `docs/<area>` | `docs/provider-reference` |
| Refactor | `refactor/<area>` | `refactor/skill-structure` |
| Chore | `chore/<description>` | `chore/update-hermes-version` |

---

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(skills): add hermes-profiles skill
fix(channels): correct Discord DM policy routing
docs(config): clarify credential pool rotation
refactor(troubleshooting): restructure error flow tables
chore: update tracked Hermes version to 2026.x
```

---

## Pull Request Process

1. **Fill out the PR template** — describe what, why, and how
2. **Link related issues** — use `Fixes #123` or `Closes #456`
3. **Keep scope focused** — one skill per PR is ideal
4. **Run the audit script** — `bash scripts/audit.sh` must pass before opening a PR
5. **Respond to feedback** — iterate until approved

PRs require at least one approval before merging.

---

## Questions?

Open an issue at https://github.com/Hashi-Ai-Dev/HermitDoc/issues for help, discussion, or feature requests.