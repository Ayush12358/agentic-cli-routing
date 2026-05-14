#!/usr/bin/env bash
# Router orchestrates delegation: Gemini -> Codex -> Copilot

set -euo pipefail

PROMPT="$*"
if [ -z "$PROMPT" ]; then
  echo "Usage: router.sh <prompt>" >&2
  exit 2
fi

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Check quota/availability for Gemini
if /bin/bash "$ROOT_DIR/scripts/quota-check.sh"; then
  echo "Routing: Gemini (preferred)" >&2
  if /bin/bash "$ROOT_DIR/scripts/gemini.sh" "$PROMPT"; then
    echo "Routing result: succeeded with Gemini" >&2
    exit 0
  else
    echo "Gemini failed; falling back to Codex" >&2
  fi
else
  echo "Gemini unavailable or quota exhausted; trying Codex" >&2
fi

# Try Codex
if /bin/bash "$ROOT_DIR/scripts/codex.sh" "$PROMPT"; then
  echo "Routing result: succeeded with Codex" >&2
  exit 0
fi

# Final fallback: Copilot (local handling)
echo "Both Gemini and Codex failed or unavailable. Falling back to Copilot." >&2
echo "(Copilot fallback) Prompt:" >&2
echo "$PROMPT" >&2

# Here we would hand off to native Copilot orchestration.
exit 1
