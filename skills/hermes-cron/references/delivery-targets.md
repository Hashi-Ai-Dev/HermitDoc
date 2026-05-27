# Cron Delivery Targets Reference

Where cron results are sent and how to configure delivery.

## Delivery Targets

| Target | Destination |
|--------|-------------|
| `origin` | Back to the chat where the job was created |
| `local` | Save to `~/.hermes/cron/output/` only |
| `discord:CHANNEL_ID` | Discord channel |
| `discord:389060154273955840` | Specific Discord channel |
| `telegram:-1001234567890` | Telegram group |
| `platform:chat_id` | Generic platform targeting |

## Delivery Examples

```python
# Daily report to Discord
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