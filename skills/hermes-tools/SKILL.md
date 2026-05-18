---
name: hermes-tools
description: "Use when looking up available tools, tool reference, or enabling/disabling tools. Covers: terminal, file, web, browser, code_execution, vision, image_gen, tts, skills, memory, session_search, delegation, cronjob, messaging, search, todo, homeassistant. Toolsets, tool configuration. Triggers on: tools, toolset, enable tool, disable tool, terminal, file, web, browser."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [tools, toolset, terminal, file, web, browser, vision, skills, memory]
    related_skills: [hermes-config, hermes-cli]
---

# Hermes Tools Reference

Complete reference for all available tools in Hermes.

## Tool Overview

| Tool | Description |
|------|-------------|
| `terminal` | Shell commands, process management |
| `file` | File read/write/search/patch |
| `web` | Web search and content extraction |
| `browser` | Browser automation (CDP) |
| `code_execution` | Sandboxed Python execution |
| `vision` | Image analysis |
| `image_gen` | AI image generation |
| `video_gen` | AI video generation |
| `tts` | Text-to-speech |
| `skills` | Skill browsing and management |
| `memory` | Persistent cross-session memory |
| `session_search` | Search past conversations |
| `delegation` | Subagent task delegation |
| `cronjob` | Scheduled task management |
| `clarify` | Ask user clarifying questions |
| `messaging` | Cross-platform message sending |
| `search` | Web search only |
| `todo` | In-session task planning |
| `homeassistant` | Smart home control |
| `rl` | Reinforcement learning tools |
| `moa` | Mixture of Agents |

## Tool Reference

### terminal

Execute shell commands:
```bash
terminal(command="ls -la", timeout=60)
```

Features:
- Background processes: `terminal(background=true)`
- Environment variables
- Working directory control
- Command timeout

### file

Read, write, search, and patch files:
```bash
read_file(path="/path/to/file", offset=1, limit=500)
write_file(content="...", path="/path/to/file")
patch(path="/path", old_string="...", new_string="...")
search_files(pattern="regex", path=".", target="content")
```

### web

Web search and content extraction:
```bash
mcp_matrix_batch_web_search(queries=[{"query": "...", "num_results": 10}])
mcp_matrix_extract_content_from_websites(tasks=[{"url": "...", "prompt": "..."}])
```

### browser

Browser automation (requires Browserbase, Camofox, or local Chromium):
```bash
# Requires browser toolset enabled
# Configure in config.yaml
```

### code_execution

Run Python in a sandbox:
```bash
execute_code(code="print('hello')")
```

### vision

Analyze images:
```bash
vision_analyze(image_url="...", question="...")
```

### image_gen

Generate images:
```bash
mcp_matrix_image_synthesize(requests=[{"prompt": "...", "output_file": "out.png"}])
```

### skills

Manage skills:
```bash
skill_manage(action="create", name="...", content="...")
skill_view(name="...")
skills_list()
```

### memory

Persistent memory:
```bash
memory(action="add", content="...", target="user")
memory(action="search", query="...")
```

### session_search

Search past conversations:
```bash
session_search(query="...", limit=5)
```

### delegation

Spawn subagents:
```bash
delegate_task(goal="...", context="...", toolsets=[...], max_iterations=50)
```

### cronjob

Schedule tasks:
```bash
cronjob(action="create", name="...", schedule="...", prompt="...", deliver="origin")
```

### messaging

Send messages:
```bash
# Platform-specific sending
# via MCP matrix tools
```

### todo

Task planning:
```bash
todo(todos=[{"id": "1", "content": "...", "status": "in_progress"}])
```

## Toolsets

Group tools for enable/disable:

| Toolset | Contains |
|---------|----------|
| `terminal` | Shell commands |
| `file` | File operations |
| `web` | Web search + extraction |
| `browser` | CDP browser automation |
| `vision` | Image analysis |
| `image_gen` | AI image generation |
| `tts` | Text-to-speech |
| `skills` | Skill management |
| `memory` | Persistent memory |
| `session_search` | Conversation search |
| `delegation` | Subagent spawning |
| `cronjob` | Scheduling |
| `clarify` | User questions |
| `messaging` | Cross-platform send |
| `search` | Web search |
| `todo` | Task planning |
| `homeassistant` | Smart home |
| `rl` | RL tools |
| `moa` | Mixture of Agents |

## Tool Management CLI

```bash
# Interactive tool manager
hermes tools

# List all tools
hermes tools list

# Enable a toolset
hermes tools enable web

# Disable a toolset
hermes tools disable browser

# Tool changes require session restart to take effect
```

## Tool Configuration

```yaml
# config.yaml
tools:
  profile: "coding"  # minimal, coding, messaging, full
  # Or individual:
  enabled:
    - terminal
    - file
    - web
```

### Tool Profiles

| Profile | Tools included |
|---------|---------------|
| `minimal` | session_status only |
| `coding` | terminal, file, web, browser, code_execution, vision, image_gen, skills, memory, session_search, delegation, cronjob |
| `messaging` | messaging tools, session_search |
| `full` | Everything |

## References

- `hermes-config/` — tool config keys
- `hermes-cli/` — tool CLI commands
- `hermes-delegation/` — delegation tools