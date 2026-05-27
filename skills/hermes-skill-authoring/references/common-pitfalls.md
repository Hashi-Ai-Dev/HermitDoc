# Common Pitfalls Reference

Documented mistakes and their fixes.

## Pitfall List

1. **Using `skill_manage(action='create')` for in-repo skills.** It writes to `~/.hermes/skills/`, not the repo tree. Use `write_file` for repo contributions.

2. **Leading whitespace before `---`.** Validator checks `content.startswith("---")`. Any leading blank line or BOM fails.

3. **Description too generic.** "Use when debugging Python" > "Debug Python". Describe the trigger class.

4. **Forgetting author/license/metadata block.** Not validator-enforced, but every peer has it.

5. **Duplicating a peer.** Check existing skills in the category first.

6. **Expecting current session to see new skill.** The skill loader is cached at session start. Verify in a fresh session.

7. **Linking to skills that don't exist in-repo.** `related_skills: [some-user-local-skill]` works for you but breaks for others.

8. **`triggers` as a separate frontmatter key instead of embedded inline.** The manifest forbids `triggers` as a top-level key. Trigger phrases must be embedded within the `description` field (e.g., `description: "Use when looking up CLI commands. Triggers on: help, terminal, flags, hermes"`).

9. **Skill name with uppercase letters.** Skill names must be lowercase hyphenated (e.g., `hermes-cli`, not `Hermes-CLI` or `hermesCLI`). The directory name, the `name:` frontmatter value, and all file references must match exactly.

10. **Description exceeding 1024 characters.** The skill authoring spec limits `description` to 1024 chars. Long descriptions should be trimmed — the body content is where detail lives.

11. **UTF-8 BOM (`\ufeff`) at start of SKILL.md.** Some editors insert a BOM. It breaks `content.startswith("---")` checks. Strip it with `sed -i '1s/^\xEF\xBB\xBF//' SKILL.md` or open and re-save as clean UTF-8.

12. **`category` set to a value not in the approved list.** Approved categories are: Core, Operations, Channels & Platforms, Tools & Providers, Concepts & Help. Using "Misc" or "Other" will fail the manifest validator.

13. **Duplicate skill names in `public_list` of HERMITDOC_MANIFEST.json.** Each skill name must appear exactly once. Duplicate entries cause installation ambiguity.

14. **Reference paths pointing outside the skills tree.** All `references/*.md` files must live under `skills/<skill-name>/references/`. Symlinks or paths like `../shared/` are not allowed — copy the content instead.

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