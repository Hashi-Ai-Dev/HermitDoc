# Cron Templates Reference

Pre-built cron job patterns for common use cases.

## Daily Report

```python
cronjob(
  action="create",
  name="daily-report",
  schedule="0 9 * * *",
  prompt="""Generate a daily status report covering:
1. Project progress (from git log, task files)
2. Any errors or warnings from logs
3. Open pull requests and their status
4. Schedule for today

Format as markdown. Keep it under 500 words.
Deliver to: origin""",
  deliver="origin"
)
```

## Health Check

```python
cronjob(
  action="create",
  name="health-check",
  schedule="*/15 * * * *",  # every 15 minutes
  prompt="""Run health checks and alert if anything is wrong:
- hermes doctor output
- disk space (df -h)
- memory usage (free -m)
- recent errors in logs

Alert if hermes doctor fails or disk > 90% full.
Report to origin only if issues found, otherwise silent.""",
  deliver="origin"
)
```

## Git Sync

```python
cronjob(
  action="create",
  name="git-sync",
  schedule="0 */4 * * *",  # every 4 hours
  prompt="""In /workspace/project, run:
1. git fetch origin
2. Check for new branches: git branch -r
3. If main has updates, summarize them

Report to origin.""",
  deliver="origin"
)
```

## Webhook-Triggered Pattern

Create a webhook that triggers a cron-style run:

```bash
hermes webhook subscribe my-webhook
# This creates: /webhooks/my-webhook
# POST to it to trigger the handler
```