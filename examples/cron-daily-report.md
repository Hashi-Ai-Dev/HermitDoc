---
name: example-cron-daily-report
description: "Daily cron job with Discord delivery for Hermes"
version: 1.0.0
author: HermitDoc
---

# Daily Report Cron Job

Schedule a daily status report delivered to Discord.

## Configuration

```python
# Create via cronjob tool
cronjob(
  action="create",
  name="daily-digest",
  schedule="0 9 * * *",  # 9 AM daily
  prompt="""Generate a daily status report covering:

1. **Project Progress** — Check git log for recent commits and summarize.
2. **System Health** — Run `hermes doctor` and report any issues.
3. **Open Tasks** — Check for pending PRs, issues, or blockers.
4. **Today's Schedule** — Preview what's planned.

Format as markdown with headers. Keep under 500 words.""",
  deliver="origin"  # deliver to the chat that created it
)
```

## Alternative: Discord Delivery

```python
cronjob(
  action="create",
  name="daily-digest-discord",
  schedule="0 9 * * *",
  prompt="""Generate daily status report and send to configured Discord channel.""",
  deliver="discord:CHANNEL_ID_HERE"
)
```

## Schedule Options

| Schedule | When |
|----------|------|
| `0 9 * * *` | Every day at 9 AM |
| `0 9 * * 1` | Every Monday at 9 AM |
| `0 */4 * * *` | Every 4 hours |
| `30m` | Every 30 minutes |

## Management

```bash
hermes cron list              # see all jobs
hermes cron run <id>         # test manually
hermes cron pause <id>       # pause
hermes cron resume <id>      # resume
hermes cron remove <id>      # delete
```