#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <owner/repo> [ref]" >&2
  echo "Example: $0 Ayush12358/agentic-cli-routing v0.1.0" >&2
  exit 2
fi

REPO="$1"
REF="${2:-main}"

TMPDIR="$(mktemp -d)"
REPO_URL="https://github.com/${REPO}.git"

echo "Cloning ${REPO}@${REF} into ${TMPDIR}..."
if command -v git >/dev/null 2>&1; then
  git clone --depth 1 --branch "$REF" "$REPO_URL" "$TMPDIR"
else
  echo "git not found; cannot clone. Install git or use download-install.sh." >&2
  exit 3
fi

SRC="$TMPDIR/.github/skills/agentic-cli-routing"
if [ ! -d "$SRC" ]; then
  echo "Skill directory not found in repository at $SRC" >&2
  rm -rf "$TMPDIR"
  exit 4
fi

DEST=".github/skills/agentic-cli-routing"
mkdir -p "$(dirname "$DEST")"

echo "Copying skill to $DEST..."
# Prefer rsync if available for safer copy
if command -v rsync >/dev/null 2>&1; then
  rsync -a --delete "$SRC/" "$DEST/"
else
  rm -rf "$DEST"
  mkdir -p "$DEST"
  cp -r "$SRC"/* "$DEST/"
fi

# Make scripts executable
if [ -d "$DEST/scripts" ]; then
  chmod +x "$DEST/scripts"/*.sh || true
fi

# Run install.sh from the skill if present
if [ -f "$DEST/install.sh" ]; then
  echo "Running skill installer..."
  bash "$DEST/install.sh" || true
elif [ -f "$DEST/scripts/install.sh" ]; then
  echo "Running skill installer script..."
  bash "$DEST/scripts/install.sh" || true
else
  echo "No installer script found; manual setup may be required." >&2
fi

# Cleanup
rm -rf "$TMPDIR"

echo "Installation complete. Skill installed at $DEST"
