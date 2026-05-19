---
name: hermes-delegation
description: "Use when spawning subagents, building multi-agent workflows, or delegating tasks. Covers: delegate_task API, toolsets, max_concurrent_children, max_spawn_depth, subagent contexts, parallelization, batch tasks, agent isolation, max_iterations, child_timeout_seconds. Triggers on: delegate, subagent, spawn, multi-agent, parallel, concurrent, delegation, parallelize, batch."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [delegation, subagent, multi-agent, parallel, spawn, toolsets]
    related_skills: [hermes-config, hermes-skills, hermes-cli, hermes-concepts]
    hermes_version: "2026.x"
---

# Hermes Delegation Reference

Guide to spawning subagents via `delegate_task`.

## delegate_task

Spawn subagents for parallel work, reasoning-heavy tasks, multi-track workflows.

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `goal` | string | — | What to accomplish. Be specific. |
| `context` | string | — | Background: file paths, error messages, constraints |
| `toolsets` | list | inherited | Tool sets to enable |
| `max_iterations` | int | 50 | Max tool-call turns per subagent |
| `tasks` | list | — | Batch mode: up to 3 parallel tasks |
| `acp_command` | string | — | Override subagent binary (e.g. `claude`, `codex`) |
| `acp_args` | list | — | Extra args for the ACP binary |
| `goal` (batch tasks) | string | — | Per-task goal |
| `context` (batch tasks) | string | — | Per-task context |
| `toolsets` (batch tasks) | list | — | Per-task toolsets |

## Batch Mode (Parallel)

Spawn up to 3 subagents simultaneously:

```python
delegate_task(tasks=[
  {
    "goal": "Write unit tests for auth.py",
    "context": "File: /project/src/auth.py. Use pytest. Run tests after.",
    "toolsets": ["terminal", "file"]
  },
  {
    "goal": "Write unit tests for database.py",
    "context": "File: /project/src/database.py. Use pytest. Run tests after.",
    "toolsets": ["terminal", "file"]
  },
  {
    "goal": "Write unit tests for api.py",
    "context": "File: /project/src/api.py. Use pytest. Run tests after.",
    "toolsets": ["terminal", "file"]
  }
])
```

## Available Toolsets

`web`, `browser`, `terminal`, `file`, `code_execution`, `vision`, `image_gen`, `tts`, `skills`, `todo`, `memory`, `session_search`, `clarify`, `delegation`, `cronjob`, `messaging`, `rl`, `homeassistant`, `moa`, `search`

Also MCP tools via `server:tool` notation (e.g. `github:create_issue`).

Default: inherits your current toolsets.

## Delegation Config

```yaml
# ~/.hermes/config.yaml
delegation:
  model: ''                    # override model for subagents (e.g. anthropic/claude-sonnet-4)
  provider: ''                   # override provider
  inherit_mcp_toolsets: true    # subagents inherit MCP tools from parent
  max_iterations: 50            # max turns per subagent
  child_timeout_seconds: 600     # timeout for subagent runs
  max_concurrent_children: 3    # max parallel subagents
  max_spawn_depth: 1            # prevent recursive delegation
```

## Context Injection

Always provide rich context:

```python
# Good
delegate_task(
  goal="Fix the authentication bug in auth.py",
  context="""
  Project: /workspace/myapp
  File: /workspace/myapp/src/auth.py (line 42)
  Error: TypeError: Cannot read property 'token' of undefined
  Stack: auth.py:42 -> middleware.py:12 -> server.py:8
  Test framework: pytest
  """
)

# Bad
delegate_task(goal="Fix the auth bug")
```

## Anti-patterns

1. **No context** — subagent doesn't know what it's doing
2. **Recursive delegation** — `max_spawn_depth: 1` prevents this
3. **Shared mutable state** — subagents are isolated
4. **User interaction** — subagents can't use `clarify`
5. **Too many concurrent** — max 3 by default

## Common Patterns

### Research Pipeline
```python
delegate_task(tasks=[
  {"goal": "Research topic A", "context": "...", "toolsets": ["web"]},
  {"goal": "Research topic B", "context": "...", "toolsets": ["web"]},
  {"goal": "Synthesize findings", "context": "Combine from tasks 1-2.", "toolsets": ["file"]}
])
```

### Code + Review
```python
delegate_task(tasks=[
  {"goal": "Implement feature X", "context": "...", "toolsets": ["terminal", "file"]},
  {"goal": "Review and test implementation", "context": "...", "toolsets": ["terminal", "file", "vision"]}
])
```

## References

- `hermes-config/` — delegation config keys
- `hermes-concepts/` — agent loop and lifecycle
- `hermes-skills/` — encoding workflows as skills
- `hermes-cli/` — delegation toolset
