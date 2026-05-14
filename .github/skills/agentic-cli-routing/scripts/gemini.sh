#!/usr/bin/env bash
# Wrapper to run Gemini CLI with a prompt. Exits non-zero on failure.

set -euo pipefail

PROMPT="$*"
if [ -z "$PROMPT" ]; then
  echo "Usage: gemini.sh <prompt>" >&2
  exit 2
fi

if ! command -v gemini >/dev/null 2>&1; then
  echo "gemini: not installed" >&2
  exit 3
fi

# Prefer JSON output for structured responses when available
gemini -p "$PROMPT" --json
exit $?
