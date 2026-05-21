---
name: hermes-cron
description: "Use when scheduling recurring tasks, managing cron jobs, or setting up automations. Covers: hermes cron CLI, schedule syntax (30m, every 2h, cron), delivery targets (origin, local, discord, telegram), script hooks, cron job management, automation patterns. Triggers on: cron, schedule, automation, recurring task, every hour, daily, weekly, cron job, background task."
version: 1.0.0
author: Hashi-Ai-Dev
license: MIT
metadata:
  hermes:
    tags: [cron, scheduling, automation, recurring-tasks, cronjobs, background-tasks]
    related_skills: [hermes-cli, hermes-delegation, hermes-gateway, hermes-security]
    hermes_version: "v2026.5.16"
---

# Hermes Cron Reference

Complete guide to scheduling recurring tasks with `hermes cron`.

## Overview

Hermes can run tasks on a schedule, delivering results to various targets. Cron jobs run in a fresh session with no user present — the prompt must be self-contained.

## Schedule Syntax

| Format | Example | Description |
|--------|---------|-------------|
| `Nm` | `30m` | Every N minutes |
| `Nh` | `2h` | Every N hours |
| `Nd` | `3d` | Every N days |
| `N w` | `2 w` | Every N weeks |
| cron | `0 9 * * *` | Standard cron (minute hour day month weekday) |
| ISO | `2025-01-15T09:00:00` | One-shot at specific time |

## Cron CLI

```bash
hermes cron list              # list all jobs
hermes cron list --all        # include disabled
hermes cron create SCHED      # interactive create
hermes cron edit ID           # edit schedule, prompt, delivery
hermes cron pause ID          # pause a job
hermes cron resume ID         # resume a paused job
hermes cron run ID            # trigger immediately
hermes cron remove ID         # delete a job
hermes cron status            # scheduler health
```

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

## Delivery Targets

Where cron results are sent:

| Target | Destination |
|--------|-------------|
| `origin` | Back to the chat where the job was created |
| `local` | Save to `~/.hermes/cron/output/` only |
| `discord:CHANNEL_ID` | Discord channel |
| `discord:389060154273955840` | Specific Discord channel |
| `telegram:-1001234567890` | Telegram group |
| `platform:chat_id` | Generic platform targeting |

Example:
```python
cronjob(
  action="create",
  schedule="0 8 * * 1",  # Every Monday 8am
  prompt="Send a weekly status report to Discord",
  deliver="discord:389060154273955840"
)
```

## Delivery Options

```python
cronjob(
  action="create",
  schedule="30m",
  prompt="Check system health and report issues",
  deliver="origin",
  script="/path/to/health_check.sh"  # run a script before/after
)
```

## Script Hooks

Run a script before or after the cron prompt:

```python
cronjob(
  action="create",
  schedule="0 9 * * *",
  prompt="Generate daily report",
  script="/path/to/setup.sh"  # runs first, stdout injected into prompt
)
```

## Cron Job Templates

### Daily Report
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

### Health Check
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

### Git Sync
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

## Pattern: Webhook-Triggered

Create a webhook that triggers a cron-style run:

```bash
hermes webhook subscribe my-webhook
# This creates: /webhooks/my-webhook
# POST to it to trigger the handler
```

## Common Pitfalls

1. **Prompt not self-contained** — Cron runs with no user context. Include all necessary info in the prompt.
2. **Wrong schedule syntax** — `30m` is every 30 minutes. `0 30 * * * *` is every hour at :30.
3. **Delivery target wrong** — Discord channel IDs need to be numeric. Use `hermes gateway status` to find IDs.
4. **Forgetting to restart** — Cron job changes apply immediately.
5. **Noisy cron jobs** — Use conditional delivery (only report on issues, not every run).
6. **Long-running prompts** — Keep prompts under 2000 tokens to avoid timeout.

## Pre-Built Cron Patterns

| Scenario | Schedule | Key tools |
|----------|----------|-----------|
| Hourly sync | `0 * * * *` | git, file |
| Daily digest | `0 9 * * *` | web, terminal |
| Weekly report | `0 9 * * 1` | session_search |
| Health check | `*/15 * * * *` | terminal |
| Backlog cleanup | `0 0 * * 0` | terminal |

## References

- `hermes-cli/` — cron CLI reference
- `hermes-gateway/` — platform integration
- `hermes-security/` — secure automation
- Official docs: https://hermes-agent.nousresearch.com/docs/
