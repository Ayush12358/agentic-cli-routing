#!/usr/bin/env bash
# Wrapper to run Codex CLI with a prompt. Exits non-zero on failure.

set -euo pipefail

PROMPT="$*"
if [ -z "$PROMPT" ]; then
  echo "Usage: codex.sh <prompt>" >&2
  exit 2
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "codex: not installed" >&2
  exit 3
fi

codex exec "$PROMPT"
exit $?
