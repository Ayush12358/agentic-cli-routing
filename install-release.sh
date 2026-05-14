#!/usr/bin/env bash
# Download and install an agentic-cli-routing release from GitHub releases
# Usage: install-release.sh <owner/repo> <tag> [asset-name]
# Example: install-release.sh myuser/gemma v0.1.0 agentic-cli-routing-v0.1.0.tar.gz

set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <owner/repo> <tag> [asset-name]" >&2
  exit 2
fi

REPO="$1"
TAG="$2"
ASSET_NAME="${3:-agentic-cli-routing-${TAG}.tar.gz}"

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${TAG}/${ASSET_NAME}"

TMPDIR="$(mktemp -d)"
ASSET_PATH="$TMPDIR/$ASSET_NAME"

echo "Downloading ${DOWNLOAD_URL}..."
if command -v curl >/dev/null 2>&1; then
  curl -L --fail -o "$ASSET_PATH" "$DOWNLOAD_URL"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$ASSET_PATH" "$DOWNLOAD_URL"
else
  echo "Neither curl nor wget is available" >&2
  exit 3
fi

echo "Extracting asset to temporary directory..."
tar -xzf "$ASSET_PATH" -C "$TMPDIR"

SKILL_DIR=".github/skills/agentic-cli-routing"
mkdir -p "$(dirname "$SKILL_DIR")"
echo "Installing skill to $SKILL_DIR"
cp -r "$TMPDIR/agentic-cli-routing" "$SKILL_DIR"

# Make scripts executable
chmod +x "$SKILL_DIR/scripts"/*.sh || true

echo "Installation complete. Cleaning up..."
rm -rf "$TMPDIR"

echo "Done. The skill is installed at $SKILL_DIR"
