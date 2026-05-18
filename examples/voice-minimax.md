---
name: example-voice-minimax
description: "MiniMax TTS and Groq STT voice configuration for Hermes"
version: 1.0.0
author: HermitDoc
---

# Voice Configuration (MiniMax TTS + Groq STT)

Configure voice mode with MiniMax text-to-speech and Groq speech-to-text.

## Prerequisites

1. `MINIMAX_API_KEY` from https://platform.minimaxi.com
2. `GROQ_API_KEY` from https://console.groq.com (free tier)

## Configuration

### 1. Add to .env

```bash
# ~/.hermes/.env
MINIMAX_API_KEY=your_minimax_key
GROQ_API_KEY=your_groq_key
```

### 2. Configure Hermes

```yaml
# config.yaml
tts:
  provider: "minimax"
  # voice_id: "optional-voice-id"

stt:
  enabled: true
  provider: "groq"
```

Or via CLI:

```bash
hermes config set tts.provider minimax
hermes config set stt.enabled true
hermes config set stt.provider groq
```

## Testing

```bash
# Test TTS
hermes voice test --tts

# Test STT
hermes voice test --stt

# Enable voice mode in chat
/voice on
```

## Voice Mode Commands

| Command | Action |
|---------|--------|
| `/voice on` | Enable voice mode |
| `/voice off` | Disable voice mode |
| `/voice tts` | TTS only (no STT) |