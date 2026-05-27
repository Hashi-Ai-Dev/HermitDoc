# Cron CLI Reference

Complete reference for `hermes cron` commands.

## Cron Commands

| Command | Description |
|---------|-------------|
| `hermes cron list` | List all jobs |
| `hermes cron list --all` | Include disabled |
| `hermes cron create SCHED` | Interactive create |
| `hermes cron edit ID` | Edit schedule, prompt, delivery |
| `hermes cron pause ID` | Pause a job |
| `hermes cron resume ID` | Resume a paused job |
| `hermes cron run ID` | Trigger immediately |
| `hermes cron remove ID` | Delete a job |
| `hermes cron status` | Scheduler health |

## Creating a Cron Job

### Via CLI (interactive)

```bash
hermes cron create "30m"
# Or with full options:
hermes cron create "0 9 * * *" --name "morning-report" --prompt "Run daily digest" --deliver discord
```

### Via Tool (in session)

```python
cronjob(
  action="create",
  name="daily-digest",
  schedule="0 9 * * *",
  prompt="Summarize key developments from the past 24 hours. Focus on: project updates, any blockers, decisions made. Format as a brief bullet-point report.",
  deliver="origin",  # deliver back to this chat
  skills=["hermes-master"]  # optional: pre-load skills
)
```

## Managing Cron Jobs

```bash
# Pause before doing maintenance
hermes cron pause <job-id>

# Resume after
hermes cron resume <job-id>

# Run manually to test
hermes cron run <job-id>

# Delete
hermes cron remove <job-id>
```