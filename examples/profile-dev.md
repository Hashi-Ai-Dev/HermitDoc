---
name: example-profile-dev
description: "Development profile with extended toolsets for Hermes"
version: 1.0.0
author: HermitDoc
---

# Development Profile

Create a dedicated development profile with extended toolsets.

## Create Profile

```bash
hermes profile create dev --clone-from default
hermes profile use dev
```

## Configure for Development

```yaml
# ~/.hermes/profiles/dev/config.yaml
model:
  default: "anthropic/claude-sonnet-4-20250514"
  provider: "anthropic"
  api_key: "${ANTHROPIC_API_KEY}"

agent:
  max_turns: 120  # More turns for complex coding tasks

terminal:
  backend: "local"
  cwd: "~/projects"
  timeout: 300  # Longer timeout for builds

tools:
  profile: "coding"  # Full coding toolset

compression:
  enabled: true
  threshold: 0.60  # Compress sooner for long sessions
```

## Set Development SOUL.md

```bash
cat > ~/.hermes/profiles/dev/SOUL.md << 'EOF'
# Dev — Development Focus

## Identity
Development-focused Hermes instance with deep coding capabilities.

## Tone
- Code-first — examples are always runnable
- Follow best practices — testing, documentation, clean code
- Suggest refactoring when code gets complex

## Specialties
- Python, TypeScript, Rust, Go
- Testing and CI/CD
- Debugging and profiling
- Architecture and system design
EOF
```

## Usage

```bash
hermes chat --profile dev
```

Or make it the default:
```bash
hermes profile use dev
```

## Switching Profiles

```bash
hermes profile list         # see all profiles
hermes profile show dev     # show dev config
hermes profile delete dev   # remove profile
```