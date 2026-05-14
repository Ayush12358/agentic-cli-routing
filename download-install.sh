#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <owner/repo> <tag>" >&2
  echo "Example: $0 Ayush12358/agentic-cli-routing v0.1.0" >&2
  exit 2
fi

REPO="$1"
TAG="$2"
ASSET_PATH="release/agentic-cli-routing-${TAG}.tar.gz"
RAW_URL="https://raw.githubusercontent.com/${REPO}/main/${ASSET_PATH}"

TMPDIR="$(mktemp -d)"
ASSET_FILE="$TMPDIR/asset.tar.gz"

echo "Downloading ${RAW_URL}..."
if command -v curl >/dev/null 2>&1; then
  curl -L --fail -o "$ASSET_FILE" "$RAW_URL"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$ASSET_FILE" "$RAW_URL"
else
  echo "Neither curl nor wget is available" >&2
  exit 3
fi

echo "Extracting and installing..."
mkdir -p "$TMPDIR/extracted"
tar -xzf "$ASSET_FILE" -C "$TMPDIR/extracted"

SKILL_DIR=".github/skills/agentic-cli-routing"
mkdir -p "$(dirname "$SKILL_DIR")"
cp -r "$TMPDIR/extracted/agentic-cli-routing" "$SKILL_DIR"

chmod +x "$SKILL_DIR/scripts"/*.sh || true

# Optional: install git hooks if repository is a git repo
if [ -d ".git" ]; then
  if [ -f "$SKILL_DIR/install.sh" ]; then
    bash "$SKILL_DIR/install.sh" || true
  elif [ -f "$SKILL_DIR/scripts/install.sh" ]; then
    bash "$SKILL_DIR/scripts/install.sh" || true
  fi
fi

# Cleanup
rm -rf "$TMPDIR"

echo "Installed agentic-cli-routing to $SKILL_DIR"
