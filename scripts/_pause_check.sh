#!/usr/bin/env bash
# Shared: any workflow sources this to early-exit if subproject is paused.
# Usage in workflow:
#   bash scripts/_pause_check.sh && echo "RUN" || echo "SKIP (paused)"
set -uo pipefail
[[ -f pause_state.json ]] || exit 0
PAUSED=$(jq -r '.paused // false' pause_state.json 2>/dev/null || echo false)
if [[ "$PAUSED" == "true" ]]; then
  echo "[paused] skipping workflow"
  exit 1
fi
exit 0
