#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
LINK_PATH="${HOME}/.local/bin/tools"

mkdir -p "$(dirname "$LINK_PATH")"
ln -sf "$SCRIPT_DIR/tools.sh" "$LINK_PATH"

echo "symlinked: $LINK_PATH -> $SCRIPT_DIR/tools.sh"
