#!/usr/bin/env bash
# Install Git hooks from .github/skills/agentic-cli-routing/hooks into .git/hooks

set -euo pipefail

REPO_ROOT="$(pwd)"
HOOKS_SRC="$REPO_ROOT/.github/skills/agentic-cli-routing/hooks"
GIT_HOOKS_DIR="$REPO_ROOT/.git/hooks"

if [ ! -d "$GIT_HOOKS_DIR" ]; then
  echo "No .git directory found. Run this from the repository root." >&2
  exit 2
fi

for f in "$HOOKS_SRC"/*; do
  name="$(basename "$f")"
  dest="$GIT_HOOKS_DIR/$name"
  cp "$f" "$dest"
  chmod +x "$dest"
  echo "Installed hook: $name"
done

echo "Hooks installed. To enable automatic routing on every commit set: export AUTO_ROUTER=1" >&2
