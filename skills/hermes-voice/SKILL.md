---
name: hermes-voice
description: "Use when configuring voice (TTS/STT) in Hermes. Covers: tts providers (edge, elevenlabs, openai, xai, mistral, neutts, piper), stt providers (local faster-whisper, groq, openai, mistral), voice config keys, provider setup. Triggers on: voice, TTS, STT, speech, transcription, text-to-speech, speech-to-text, voice mode."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [voice, TTS, STT, speech, transcription, audio]
    related_skills: [hermes-config, hermes-cli]
    hermes_version: "v2026.5.16"
---

# Hermes Voice Reference

Voice configuration — TTS (text-to-speech) and STT (speech-to-text). No `hermes voice` CLI command exists — voice is configured via `config.yaml`.

## TTS Providers

| Provider | Quality | Cost | Config key |
|----------|---------|------|------------|
| Edge TTS | Good | Free | `tts.provider: edge` |
| ElevenLabs | Excellent | Free tier | `tts.provider: elevenlabs` |
| OpenAI | Good | Paid | `tts.provider: openai` |
| xAI | Good | API cost | `tts.provider: xai` |
| Mistral | Good | Paid | `tts.provider: mistral` |
| NeuTTS | Good | Free | `tts.provider: neutts` |
| Piper | Good | Free | `tts.provider: piper` |

## STT Providers

| Provider | Quality | Cost | Config key |
|----------|---------|------|------------|
| Local (faster-whisper) | Good | Free | `stt.provider: local` |
| Groq Whisper | Excellent | Free tier | `stt.provider: groq` |
| OpenAI Whisper | Good | Paid | `stt.provider: openai` |
| Mistral Voxtral | Good | Paid | `stt.provider: mistral` |

## Configuration

### TTS

```yaml
# ~/.hermes/config.yaml
tts:
  provider: edge          # provider name
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

### STT

```yaml
stt:
  enabled: true
  provider: local          # or groq, openai, mistral
  local:
    # No extra config needed if faster-whisper is installed
```

## Enabling Voice

Enable the TTS toolset:

```bash
hermes tools enable tts
```

Voice is controlled in-session:
```bash
/voice on    # enable voice mode
/voice off   # disable
```

## Local Whisper Setup

```bash
# Install faster-whisper
pip install faster-whisper

# Then in config:
stt:
  provider: local
```

## Voice in Session

When enabled, Hermes responds with voice in supported platforms (Telegram, Discord with voice channels).

## References

- `hermes-config/` — voice config keys
- `hermes-cli/` — tools CLI commands
- `hermes-tools/` — enabling TTS toolset</parameter>
