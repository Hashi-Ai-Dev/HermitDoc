# Toolsets Reference

Group tools for enable/disable management.

## Toolset Contents

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

# List tools for a specific platform (cli, telegram, discord, etc.)
hermes tools list --platform telegram

# Enable a toolset
hermes tools enable web

# Enable a toolset for a specific platform
hermes tools enable messaging --platform discord

# Disable a toolset
hermes tools disable browser

# Disable a specific MCP tool
hermes tools disable github:create_issue --platform telegram
```

> Tool changes require session restart to take effect.

## Tool Profiles

| Profile | Tools included |
|---------|---------------|
| `minimal` | session_status only |
| `coding` | terminal, file, web, browser, code_execution, vision, image_gen, skills, memory, session_search, delegation, cronjob |
| `messaging` | messaging tools, session_search |
| `full` | Everything |