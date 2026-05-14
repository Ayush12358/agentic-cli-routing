#!/usr/bin/env bash
# Install the latest release (or main) of the repo and run the bundled installer.
# Usage: ./install-latest.sh [owner/repo]

set -euo pipefail

REPO="${1:-Ayush12358/agentic-cli-routing}"
TMPDIR="$(mktemp -d)"

echo "Determining latest release for ${REPO}..."
TAG=""
if command -v curl >/dev/null 2>&1; then
  TAG=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep -m1 '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/') || true
fi

if [ -z "${TAG}" ]; then
  echo "No latest release found (or API rate-limited); falling back to 'main' branch."
  TAG="main"
fi

echo "Cloning ${REPO}@${TAG} into ${TMPDIR}..."
if command -v git >/dev/null 2>&1; then
  git clone --depth 1 --branch "$TAG" "https://github.com/${REPO}.git" "$TMPDIR"
else
  echo "git is required to run this installer." >&2
  rm -rf "$TMPDIR"
  exit 2
fi

if [ -f "$TMPDIR/release/installer.sh" ]; then
  echo "Running bundled release installer..."
  chmod +x "$TMPDIR/release/installer.sh" || true
  bash "$TMPDIR/release/installer.sh" "$REPO" "$TAG"
else
  echo "Bundled installer not found; copying skill files directly."
  if [ -d "$TMPDIR/.github/skills/agentic-cli-routing" ]; then
    mkdir -p .github/skills
    rm -rf .github/skills/agentic-cli-routing || true
    cp -r "$TMPDIR/.github/skills/agentic-cli-routing" .github/skills/
    chmod +x .github/skills/agentic-cli-routing/scripts/*.sh || true
    echo "Skill files copied to .github/skills/agentic-cli-routing"
  else
    echo "Skill directory not present in the repository." >&2
    rm -rf "$TMPDIR"
    exit 3
  fi
fi

rm -rf "$TMPDIR"
echo "Installation finished. Cleaned up temporary files."
