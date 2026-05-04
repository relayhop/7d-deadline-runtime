# 7d-deadline-runtime

Cloud runtime for `subprojects/7d-deadline/` — GH Actions cron workflows.

## Subproject

Mother project: [`relayhop/ClaudeEarnSelf`](https://github.com/relayhop/ClaudeEarnSelf-runtime) (母 24h 死線)
This repo: 7d-deadline 子專案(鬆綁 24h → 7d active hours)
SN subproject: [`relayhop/sn-monetization-runtime`](https://github.com/relayhop/sn-monetization-runtime)

## Workflows

| Workflow | Schedule | Purpose |
|---|---|---|
| `check_stale_strategies_7d.yml` | hourly | 48h dynamic idle detection (24h warn / 36h push / 48h auto-pause N2m) |
| `progress_poller_*.yml` × 10 | 1-4h | Per profit_model progress signal polling |
| `floor_refill.yml` | hourly | Active < 5 / token idle → take next candidate |
| `daily_summary.yml` | daily 09:00 UTC+8 | Layer 1 daily report → GH Issue |
| `disconnect_detector.yml` | hourly | Mac > 24h no push → auto pause + cloud notify |

## Pause flag

When subproject is paused, `pause_state.json` is committed at repo root. All cron workflows check this file and skip if `paused: true`.

## Data

`data/` directory accumulates cron output (committed automatically by workflows):
- `data/strategy_progress.tsv` — progress signals
- `data/income_events.log` — incomes
- `data/pollers/<model>/*.json` — per-poller raw output

## Secrets (set via GH web UI)

| Secret | Required | Purpose |
|---|---|---|
| `ANTHROPIC_API_KEY` | optional | Claude API for evaluation/reclassify |
| `COINOS_JWT` | optional | LN income polling |
| `DISCORD_WEBHOOK_URL` | optional | Push notification to Jeff phone |
| `TELEGRAM_BOT_TOKEN` + `TELEGRAM_CHAT_ID` | optional | Telegram push (alt) |

Without secrets, workflows still run but use GH Issues for notification.

## Manual triggers

All workflows support `workflow_dispatch` for manual run via Actions tab.
