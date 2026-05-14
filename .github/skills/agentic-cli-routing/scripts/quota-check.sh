#!/usr/bin/env bash
# Simple quota check: consult environment variable GEMINI_QUOTA
# Returns 0 if Gemini should be used, non-zero otherwise.

set -euo pipefail

if [[ -n "${GEMINI_QUOTA-}" ]]; then
  if [[ "${GEMINI_QUOTA}" =~ ^[0-9]+$ ]] && [ "${GEMINI_QUOTA}" -gt 0 ]; then
    exit 0
  fi
fi

# Fallback: check whether gemini binary exists and is callable
if command -v gemini >/dev/null 2>&1; then
  exit 0
fi

exit 1
