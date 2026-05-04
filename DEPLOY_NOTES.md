# 7d-deadline-runtime — Deploy Notes

> Runtime repo: `relayhop/7d-deadline-runtime`(待 Jeff 確認 gh CLI 後建立)

## 啟動建立步驟(待 Jeff 觸發)

```bash
# 1. 確認 GH PAT(Keychain)
PAT=$(security find-generic-password -s 'ClaudeEarnSelf-gh-pat' -a 'relayhop' -w)

# 2. 建 public repo
echo "$PAT" | gh auth login --with-token
gh repo create relayhop/7d-deadline-runtime --public --description "7d-deadline subproject runtime — GH Actions cron + workflows"

# 3. 連到本地 runtime/ 目錄
cd subprojects/7d-deadline/runtime
git init
git remote add origin https://github.com/relayhop/7d-deadline-runtime.git

# 4. 推 placeholder
echo "# 7d-deadline-runtime" > README.md
git add README.md && git commit -m "Initial commit"
git push -u origin main
```

## 待部署 Workflows(隨後逐個推)

| File | 頻率 | 用途 |
|---|---|---|
| `.github/workflows/check_stale_strategies_7d.yml` | hourly | 48h idle 動態偵測 |
| `.github/workflows/progress_poller_<model>.yml` × 10 | 1-4h | 各 profit_model 進度訊號 |
| `.github/workflows/floor_refill.yml` | hourly | active < 5 / token 閒置補充 |
| `.github/workflows/daily_summary.yml` | daily 09:00 UTC+8 | Layer 1 報告 |
| `.github/workflows/disconnect_detector.yml` | hourly | Mac > 24h 無 push → auto pause + 雲端 push 通知 |

## 共用既有資源

- GH PAT: `ClaudeEarnSelf-gh-pat` Keychain(scopes: repo / workflow / delete_repo;90d expiry 2026-07-25)
- CF account: 共用母 `b3e4c5b9ecb1a8e94f6835d0622f7a5d`(若需 Worker host LN paywall API)
- Proton mail: `relayhop@proton.me`(若 GH Actions 寄通知)

## 與既有 runtime 區分

| Repo | 用途 |
|---|---|
| `relayhop/ClaudeEarnSelf-runtime` | 母 24h 專案 cron |
| `relayhop/sn-monetization-runtime` | SN 子專案 cron |
| **`relayhop/7d-deadline-runtime`** | **本子專案 cron(待建)** |

三 repo 互不污染,各自 GH Actions 配額獨立(public = unlimited)。

## 下一步

待 Jeff 顯式觸發後,執行上述「啟動建立步驟」。在那之前不會建立 remote repo。
