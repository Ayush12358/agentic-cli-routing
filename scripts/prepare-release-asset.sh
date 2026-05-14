#!/usr/bin/env bash
# Prepare a tar.gz release asset containing the skill directory

set -euo pipefail

TAG="${1:-v0.1.0}"
OUTDIR="release"
ASSET_NAME="agentic-cli-routing-${TAG}.tar.gz"

mkdir -p "$OUTDIR"

# Pack the skill directory
tar -czf "$OUTDIR/$ASSET_NAME" -C . .github/skills/agentic-cli-routing

echo "Created release asset: $OUTDIR/$ASSET_NAME"
