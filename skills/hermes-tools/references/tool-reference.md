# Tool Reference

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

## Individual Tool Details

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