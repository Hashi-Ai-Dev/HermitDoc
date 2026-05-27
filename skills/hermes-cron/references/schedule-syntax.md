# Cron Schedule Syntax Reference

Complete reference for cron schedule formats.

## Schedule Formats

| Format | Example | Description |
|--------|---------|-------------|
| `Nm` | `30m` | Every N minutes |
| `Nh` | `2h` | Every N hours |
| `Nd` | `3d` | Every N days |
| `N w` | `2 w` | Every N weeks |
| cron | `0 9 * * *` | Standard cron (minute hour day month weekday) |
| ISO | `2025-01-15T09:00:00` | One-shot at specific time |

## Cron Expression Format

Standard cron: `minute hour day month weekday`

### Examples

| Expression | Meaning |
|------------|---------|
| `0 * * * *` | Every hour at minute 0 |
| `30 * * * *` | Every hour at minute 30 |
| `0 9 * * *` | Daily at 9:00 AM |
| `0 9 * * 1` | Every Monday at 9:00 AM |
| `*/15 * * * *` | Every 15 minutes |
| `0 */4 * * *` | Every 4 hours |
| `0 0 * * 0` | Every Sunday at midnight |

## Common Patterns

| Scenario | Schedule |
|----------|----------|
| Hourly sync | `0 * * * *` |
| Daily digest | `0 9 * * *` |
| Weekly report | `0 9 * * 1` |
| Health check | `*/15 * * * *` |
| Backlog cleanup | `0 0 * * 0` |