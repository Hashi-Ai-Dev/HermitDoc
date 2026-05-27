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