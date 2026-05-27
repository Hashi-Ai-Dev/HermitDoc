# Environment Variables Reference

Environment variables for API keys and configuration.

## API Keys

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

## Common Fixes

**Config changes not applying:**
- Some require new session: `/reset`
- Tools changes require session restart

**Provider not working:**
- Verify API key in `.env`
- Check `hermes config check`