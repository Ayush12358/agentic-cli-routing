#!/usr/bin/env bash
# Standalone installer included in the release asset.
# Usage: bash installer.sh <owner/repo> [tag]

set -euo pipefail

REPO="${1:-Ayush12358/agentic-cli-routing}"
REF="${2:-v0.1.1}"

echo "Installer (release asset) -> Installing ${REPO}@${REF}"

TMPDIR="$(mktemp -d)"
echo "Cloning into $TMPDIR..."
git clone --depth 1 --branch "$REF" "https://github.com/${REPO}.git" "$TMPDIR"

if [ -d "$TMPDIR/.github/skills/agentic-cli-routing" ]; then
  echo "Copying skill into .github/skills/agentic-cli-routing"
  mkdir -p .github/skills
  rm -rf .github/skills/agentic-cli-routing || true
  cp -r "$TMPDIR/.github/skills/agentic-cli-routing" .github/skills/
  chmod +x .github/skills/agentic-cli-routing/scripts/*.sh || true
  if [ -f .github/skills/agentic-cli-routing/install.sh ]; then
    bash .github/skills/agentic-cli-routing/install.sh || true
  fi
  echo "Installed skill to .github/skills/agentic-cli-routing"
else
  echo "Skill directory not found in release archive." >&2
  exit 1
fi

rm -rf "$TMPDIR"
echo "Done. Cleaned up temporary files."
