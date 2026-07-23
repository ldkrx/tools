#!/usr/bin/env bash
set -euo pipefail

TOOLS_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# Discover tools: any subdirectory containing a compose file
discover_tools() {
    for dir in "$TOOLS_DIR"/*/; do
        [ -d "$dir" ] || continue
        name="$(basename "$dir")"
        for f in "$dir"compose.yml "$dir"compose.yaml "$dir"docker-compose.yml "$dir"docker-compose.yaml; do
            [ -f "$f" ] && echo "$name" && break
        done
    done
}

# Find the compose file for a given tool name
find_compose_file() {
    local name="$1"
    local dir="$TOOLS_DIR/$name"
    [ -d "$dir" ] || return 1
    for f in "$dir"/compose.yml "$dir"/compose.yaml "$dir"/docker-compose.yml "$dir"/docker-compose.yaml; do
        [ -f "$f" ] && echo "$f" && return 0
    done
    return 1
}

usage() {
    local tools
    tools="$(discover_tools)"
    cat <<EOF
Usage: tools <command> <tool>

Commands:
  start   <tool>   Start a tool
  stop    <tool>   Stop a tool
  reload  <tool>   Restart a tool
  ls               List available tools

Available tools:
EOF
    for t in $tools; do
        echo "  $t"
    done
}

ACTION="${1:-}"
TOOL="${2:-}"

case "${ACTION}" in
    ls)
        discover_tools
        exit 0
        ;;
esac

if [[ -z "$TOOL" ]]; then
    usage
    exit 1
fi

COMPOSE_FILE="$(find_compose_file "$TOOL")" || {
    echo "error: unknown tool '$TOOL'" >&2
    echo >&2
    usage >&2
    exit 1
}

case "$ACTION" in
    start)
        docker compose -f "$COMPOSE_FILE" up -d
        ;;
    stop)
        docker compose -f "$COMPOSE_FILE" down
        ;;
    reload)
        docker compose -f "$COMPOSE_FILE" restart
        ;;
    *)
        echo "error: unknown command '$ACTION'" >&2
        echo >&2
        usage >&2
        exit 1
        ;;
esac
