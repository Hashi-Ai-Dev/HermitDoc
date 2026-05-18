# Agent Template

This folder contains template files for creating Hermes Agent personas and operating instructions.

## Files

### AGENTS.md

Operating instructions for the agent — purpose, principles, routing, tool usage, known patterns.

Copy to your agent's workspace:
```bash
cp agent-template/AGENTS.md ~/.hermes/profiles/<name>/
```

### SOUL.md

Persona template for the agent — identity, tone, boundaries, specialties.

See `hermes-soul` skill for full SOUL.md authoring guide and examples.

## Customization

Create a profile with custom templates:
```bash
hermes profile create my-agent --clone-from default
cp agent-template/SOUL.md ~/.hermes/profiles/my-agent/SOUL.md
cp agent-template/AGENTS.md ~/.hermes/profiles/my-agent/AGENTS.md
hermes profile use my-agent
```