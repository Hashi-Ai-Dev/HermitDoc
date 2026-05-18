# Troubleshooting

Common issues and their fixes.

---

## Skills Not Loading

**Symptoms:** `hermes skills list` doesn't show HermitDoc skills after install.

**Fix:**
1. Restart the session: `/reset`
2. Verify the skills were copied:
   ```bash
   ls ~/.hermes/skills/ | grep -i hermit
   ```
3. If empty, re-run the install:
   ```bash
   cp -r /tmp/hermitdoc/skills/* ~/.hermes/skills/
   /reset
   ```

---

## Hermes Doctor Failing

**Symptoms:** `hermes doctor` reports errors.

**Fix:**
```bash
# Run with auto-fix
hermes doctor --fix

# If that doesn't work, check each component:
hermes status --all

# Common issues:
# - Missing API keys → add to ~/.hermes/.env
# - Config syntax error → hermes config edit
# - Gateway not running → hermes gateway start
```

---

## Config Changes Not Applying

**Symptoms:** Edited `config.yaml` but Hermes behaves the same.

**Fix:**
Some config changes require a session restart:
```bash
/reset
```
Or start a new `hermes chat` session.

Hot-reload applies to: tools, skills, channels (most changes).

Restart required for: model provider changes, security settings.

---

## Channel Not Responding

**Symptoms:** Bot doesn't reply to messages.

**Fix per channel:**

**Discord:**
- Verify Message Content Intent is enabled in Discord Developer Portal
- Check bot token in config: `hermes config edit`
- Verify mention format: `<@bot-id>` not plain `@name`
- Check `requireMention` setting in config

**Telegram:**
- Verify bot token in `TELEGRAM_BOT_TOKEN` env var
- Check `requireMention: false` if you want always-on in groups
- Verify webhook isn't conflicting with long-polling

**Other channels:**
```bash
hermes gateway status
hermes channels status
```

---

## Cron Jobs Not Running

**Symptoms:** Scheduled jobs don't fire.

**Fix:**
```bash
# List all cron jobs
hermes cron list --all

# Check scheduler status
hermes cron status

# Run manually to test
hermes cron run <job-id>

# Check logs
tail ~/.hermes/logs/
```

Common causes: wrong schedule syntax, delivery target down, script errors.

---

## Skill Validation Fails

**Symptoms:** Error when creating or installing a skill.

**Fix:**
Validate your SKILL.md:
```python
import yaml, re, pathlib
content = pathlib.Path("skills/<name>/SKILL.md").read_text()
assert content.startswith("---")
m = re.search(r'\n---\s*\n', content[3:])
fm = yaml.safe_load(content[3:m.start()+3])
assert "name" in fm and "description" in fm
assert len(fm["description"]) <= 1024
assert len(content) <= 100000
print("Valid!")
```

---

## Git Clone Fails

**Symptoms:** `git clone` times out or fails.

**Fix:**
```bash
# Use SSH instead of HTTPS
git clone git@github.com:Hashi-Ai-Dev/HermitDoc.git /tmp/hermitdoc

# Or retry with timeout
git clone --depth 1 https://github.com/Hashi-Ai-Dev/HermitDoc.git /tmp/hermitdoc
```

---

## Gateway Won't Start

**Symptoms:** `hermes gateway run` fails.

**Fix:**
```bash
# Check if already running
ps aux | grep hermes

# Kill existing process
pkill -f hermes-gateway

# Check config
hermes config check

# Run with verbose output
hermes gateway run -v
```

---

## Memory / Session Search Not Working

**Symptoms:** `session_search` returns no results, memory seems empty.

**Fix:**
```bash
# Check memory status
hermes memory status

# Enable if disabled
hermes memory setup

# Check Honcho integration if using it
hermes honcho setup
hermes honcho status

# Session search index may need rebuilding — check logs
tail ~/.hermes/logs/
```

---

## Permission Denied Errors

**Symptoms:** Cannot read/write files, commands fail with permission error.

**Fix:**
```bash
# Check Hermes config directory permissions
ls -la ~/.hermes/

# Fix if needed
chmod 700 ~/.hermes/
chmod 600 ~/.hermes/config.yaml
chmod 600 ~/.hermes/.env

# For specific files
chmod 644 ~/.hermes/skills/*/SKILL.md
```

---

## Need More Help?

- Hermes docs: https://hermes-agent.nousresearch.com/docs/
- HermitDoc issues: https://github.com/Hashi-Ai-Dev/HermitDoc/issues
- Nous Research Discord: https://discord.gg/nousresearch

When reporting an issue, include:
- `hermes doctor` output
- Your OS and Hermes version (`hermes --version`)
- Steps to reproduce
- Relevant config snippets (remove secrets)