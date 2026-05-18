---
name: hermes-hooks
description: "Use when managing shell hooks in Hermes. Covers: hermes hooks CLI (list, test, revoke, doctor), hook configuration in config.yaml, shell-hooks-allowlist.json, first-use consent, hook events (pre/post), hook patterns, hook security. Triggers on: hooks, shell hooks, pre-hook, post-hook, automation, trigger."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [hooks, shell-hooks, automation, pre-hook, post-hook, triggers]
    related_skills: [hermes-security, hermes-cron, hermes-cli]
---

# Hermes Hooks Reference

Shell script hooks — run custom scripts at specific points in Hermes execution.

## Hooks CLI

```bash
hermes hooks list               # List configured hooks (matcher, timeout, consent status)
hermes hooks test EVENT         # Fire every hook matching EVENT against a synthetic payload
hermes hooks revoke COMMAND     # Remove a command's allowlist entries
hermes hooks doctor             # Diagnose each hook: exec bit, allowlist, mtime drift, JSON validity, timing
```

## Hook Configuration

```yaml
# ~/.hermes/config.yaml
hooks:
  - name: "pre-terminal"
    event: "pre_tool_call"
    matcher: "terminal"
    command: "/path/to/hook.sh"
    timeout_seconds: 5
    allowlist: true  # pre-approved (no prompt needed)
  - name: "post-terminal"
    event: "post_tool_call"
    matcher: "terminal"
    command: "/path/to/hook2.sh"
    timeout_seconds: 5
```

## Hook Events

| Event | When it fires |
|-------|---------------|
| `pre_tool_call` | Before a tool is called |
| `post_tool_call` | After a tool completes |
| `pre_agent_loop` | Before agent loop iteration |
| `post_agent_loop` | After agent loop iteration |

## Hook Environment Variables

| Variable | Contents |
|----------|----------|
| `HERMES_TOOL` | Tool being called (e.g. `terminal`) |
| `HERMES_TOOL_ARGS` | Tool arguments (JSON) |
| `HERMES_EXIT` | Exit status |
| `HERMES_SESSION_ID` | Current session ID |

## First-Use Consent

First time a hook fires, Hermes prompts for consent. Decisions are stored in:

```
~/.hermes/shell-hooks-allowlist.json
```

Manage the allowlist:

```bash
# Test hooks (fires against synthetic payload)
hermes hooks test pre_tool_call

# Revoke allowlist entries for a command
hermes hooks revoke "/path/to/hook.sh"
```

## Hook Security

1. **Allowlist** — hooks don't fire until approved
2. **Timeout** — prevents hanging hooks
3. **Event filtering** — use `matcher` to target specific tools

## Hook Doctor

```bash
hermes hooks doctor
# Checks each hook:
# - Exec bit set
# - Allowlist status
# - File modification time drift
# - JSON validity of config
# - Synthetic run timing
```

## Common Issues

**Hook not firing:**
- Not in allowlist — `hermes hooks list` to check
- Wrong event type — verify event in config
- File not executable — `chmod +x`

**Hook blocking execution:**
- Exit 1 blocks the tool call
- Fix the hook or `hermes hooks revoke`

## References

- `hermes-security/` — allowlist management
- `hermes-cli/` — hooks CLI commands
- `hermes-logging/` — audit logging