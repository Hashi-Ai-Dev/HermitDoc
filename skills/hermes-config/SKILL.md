---
name: hermes-config
description: "Use when auditing or editing config.yaml. Covers: all real config keys: channels, delegation, memory, stt, tts, logging, model, provider, kanban, code_execution, network, model_catalog. Also covers: env vars, credentials, profiles, hermes config CLI. Triggers on: config, config.yaml, configuration, config reference, credentials, profiles."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [config, config.yaml, environment, credentials, profiles]
    related_skills: [hermes-cli, hermes-providers, hermes-security]
    hermes_version: "2026.x"
---

# Hermes Config Reference

Verified config keys from `~/.hermes/config.yaml`.

## Config CLI

```bash
hermes config show           # view current config
hermes config edit           # open in $EDITOR
hermes config set KEY VAL   # set a value
hermes config path          # print config path
hermes config env-path      # print .env path
hermes config check          # validate config
hermes config migrate       # update with new options
```

## Real Config Keys

### delegation

```yaml
delegation:
  model: ''                      # override model for subagents
  provider: ''                   # override provider
  base_url: ''
  api_key: ''
  inherit_mcp_toolsets: true     # subagents inherit MCP toolsets
  max_iterations: 50            # max turns per subagent
  child_timeout_seconds: 600
  reasoning_effort: ''
  max_concurrent_children: 3    # max parallel subagents
  max_spawn_depth: 1            # prevent recursive spawning
```

### memory

```yaml
memory:
  memory_enabled: true
  user_profile_enabled: true
  memory_char_limit: 2200       # max chars per memory entry
  user_char_limit: 1375         # max chars per user profile entry
  provider: ''                   # empty = built-in only
```

### channels

```yaml
channels:
  discord:
    token: "${DISCORD_BOT_TOKEN}"
    require_mention: true
    free_response_channels: ''
    allowed_channels: ''
    auto_thread: true
    reactions: true
    channel_prompts: {}
    server_actions: ''
  telegram:
    botToken: "${TELEGRAM_BOT_TOKEN}"
    reactions: false
    channel_prompts: {}
  slack:
    botToken: "${SLACK_BOT_TOKEN}"
    signingSecret: "${SLACK_SIGNING_SECRET}"
    channel_prompts: {}
  whatsapp: {}
```

### stt

```yaml
stt:
  enabled: true
  provider: local           # local, groq, openai, mistral
  local: {}                # uses faster-whisper
```

### tts

```yaml
tts:
  provider: edge           # edge, elevenlabs, openai, xai, mistral, neutts, piper
  edge:
    voice: en-US-AriaNeural
  elevenlabs:
    voice_id: your-voice-id
  openai:
    model: gpt-4o-mini-tts
    voice: alloy
  xai:
    voice_id: eve
    language: en
    sample_rate: 24000
  mistral:
    model: voxtral-mini-tts-2603
    voice_id: your-voice-id
  neutts:
    ref_audio: ''
    ref_text: ''
    model: neuphonic/neutts-air-q4-gguf
    device: cpu
  piper:
    voice: en_US-lessac-medium
```

### logging

```yaml
logging:
  level: INFO              # DEBUG, INFO, WARNING, ERROR
  max_size_mb: 5           # rotate logs at this size
  backup_count: 3           # keep N backup files
```

### model_catalog

```yaml
model_catalog:
  enabled: true
  url: https://hermes-agent.nousresearch.com/docs/api/model-catalog.json
  ttl_hours: 24
  providers: {}             # provider overrides
```

### kanban

```yaml
kanban:
  dispatch_in_gateway: true
  dispatch_interval_seconds: 60
```

### code_execution

```yaml
code_execution:
  mode: project           # how code execution is sandboxed
```

### network

```yaml
network:
  force_ipv4: false
```

### container

```yaml
container_memory: 5120
container_disk: 51200
container_persistent: true
docker_volumes: []
docker_mount_cwd_to_workspace: false
docker_run_as_host_user: false
```

### privacy

```yaml
redact_pii: true            # hash user IDs, strip phone numbers
```

## Environment Variables

Set in `~/.hermes/.env`:

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_API_KEY` | Anthropic |
| `OPENAI_API_KEY` | OpenAI |
| `OPENROUTER_API_KEY` | OpenRouter |
| `DEEPSEEK_API_KEY` | DeepSeek |
| `GEMINI_API_KEY` | Google Gemini |
| `XAI_API_KEY` | xAI/Grok |
| `MINIMAX_API_KEY` | MiniMax |
| `GROQ_API_KEY` | Groq |
| `MISTRAL_API_KEY` | Mistral |
| `ELEVENLABS_API_KEY` | ElevenLabs |
| `HF_TOKEN` | Hugging Face |

## Common Fixes

**Config changes not applying:**
- Some require new session: `/reset`
- Tools changes require session restart

**Provider not working:**
- Verify API key in `.env`
- Check `hermes config check`

## References

- `hermes-cli/` — config CLI commands
- `hermes-providers/` — model providers
- `hermes-security/` — security config</parameter>
