# HermitDoc Changelog

All notable changes to HermitDoc are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-05-18

### Added

**23 Skills** covering the complete Hermes Agent knowledge base:

#### Core (5 skills)
- `hermes-master` — Top-level routing hub with skill map and architecture overview
- `hermes-config` — Verified config.yaml keys: delegation, memory, channels, stt, tts, logging, kanban, network, model_catalog, container, privacy
- `hermes-skills` — Full skills CLI reference: browse, search, install, inspect, list, check, update, audit, uninstall, reset, publish, snapshot, tap, config
- `hermes-delegation` — delegate_task API, batch mode, toolsets, delegation config (max_concurrent_children, max_spawn_depth, child_timeout_seconds, inherit_mcp_toolsets)
- `hermes-memory` — Built-in memory (MEMORY.md/USER.md), 8 external providers (Honcho, Mem0, holographic, hindsight, openviking, retaindb, byterover, supermemory), hermes memory CLI

#### Operations (5 skills)
- `hermes-cron` — Scheduling with real CLI: create, list, edit, pause, resume, run, remove, status, tick. Delivery targets: origin, local, telegram, discord, signal, platform:chat_id. Script hooks and workdir injection.
- `hermes-troubleshooting` — Diagnostic flow: doctor, status, logs, config check, gateway, memory. All CLI-verified commands.
- `hermes-logging` — hermes logs CLI: agent/errors/gateway logs, levels, filtering (--level, --session, --since, --component, --component), follow mode, log rotation config
- `hermes-security` — Approvals mode, YOLO, redact_secrets, redact_pii, shell hooks allowlist
- `hermes-hooks` — hermes hooks CLI: list, test, revoke, doctor. Hook config, events (pre_tool_call, post_tool_call, pre_agent_loop, post_agent_loop), first-use consent

#### Channels & Platforms (5 skills)
- `hermes-channels` — Verified config keys: discord (token, require_mention, free_response_channels, allowed_channels, auto_thread, reactions, channel_prompts), telegram (botToken, reactions), slack (botToken, signingSecret), whatsapp
- `hermes-gateway` — hermes gateway CLI: run/start/stop/restart/status/install/uninstall/setup/migrate-legacy. No manual port exposure.
- `hermes-mcp` — hermes mcp CLI: serve, add, remove, list, test, configure, login. HTTP/SSE and stdio transports, auth (oauth, header), presets, --env vars
- `hermes-platforms` — Linux (systemd), macOS (LaunchAgent), WSL2, Termux, Docker (resource limits), cloud (EC2, Railway, Fly.io)
- `hermes-install` — Install script, Linux, macOS, WSL2, Termux, Docker, cloud platforms, update, uninstall

#### Tools & Providers (4 skills)
- `hermes-voice` — TTS providers (edge, elevenlabs, openai, xai, mistral, neutts, piper) and STT providers (local faster-whisper, groq, openai, mistral). Config-only, no fake CLI.
- `hermes-providers` — Real provider list: MiniMax, OpenRouter, Anthropic, DeepSeek, Google, Groq, Mistral, xAI, Nous Portal, Kilo Code, Kimi, DashScope, GLM, MiMo, Hugging Face, Ollama, AI Gateway, OpenCode. hermes model/login/logout/auth/fallback CLI.
- `hermes-tools` — Full toolsets reference: web, browser, terminal, file, code_execution, vision, image_gen, tts, skills, todo, memory, session_search, clarify, delegation, cronjob, messaging, rl, homeassistant, moa. hermes tools CLI: list, enable, disable.
- `hermes-cli` — Complete verified CLI reference: chat, config, model, auth, fallback, skills, tools, cron, gateway, pairing, sessions, mcp, webhook, hooks, logs, memory, plugins, kanban, insights, curator, dashboard, backup, import, dump, debug, acp, claw, profile, completion, version, update, uninstall. Plus all in-session slash commands.

#### Concepts & Help (4 skills)
- `hermes-soul` — SOUL.md authoring with real examples and templates
- `hermes-concepts` — Session system, context assembly, compression (threshold, target_ratio), bootstrap files (SOUL.md, USER.md, AGENTS.md, IDENTITY.md, HEARTBEAT.md, MEMORY.md, TOOLS.md), agent loop lifecycle, checkpoints, profiles, agent vs subagent
- `hermes-skill-authoring` — SKILL.md format, frontmatter (name, description ≤1024 chars, version, author, license, metadata.hermes.{tags, related_skills}), size limits (≤100KB), categories, validator script, peer-matched structure
- `hermitdoc-onboarding` — Guided setup with install modes, quick start checklist, skill tree overview

**Documentation & Templates:**
- README.md with full skill tree and install instructions
- QUICKSTART.md (10-minute guide)
- AGENT_INSTALL.md (Mode 1: profile-based persistent agent)
- SKILLS_INSTALL.md (Mode 2: skills-only)
- CONTRIBUTING.md with skill format guide and validation script
- CODE_OF_CONDUCT.md, SECURITY.md, LICENSE
- HERMITDOC_MANIFEST.json (machine-readable index)
- AUDIT.md with pre-release validation script
- TROUBLESHOOTING.md
- agent-template/ (AGENTS.md, README.md)
- 9 example configs: discord-channel, telegram-channel, openrouter-provider, anthropic-deepseek, cron-daily-report, voice-minimax, profile-dev, mcp-github, security-hardened
- scripts/audit.sh (pre-release validation)
- .github/ISSUE_TEMPLATE/ (bug_report, feature_request, config_help)
- .gitignore

### Removed
- All placeholder/fabricated CLI commands (hermes voice, herus, etc.)
- Incorrect config key paths
- Wrong port references
- Non-existent commands (channels list/enable/disable, hermes browse, etc.)

### Notes
- All CLI commands verified against actual `hermes --help` and per-command `--help`
- All config keys verified against real `~/.hermes/config.yaml`
- Skills are Hermes-agent-native, not a ClawDoc clone