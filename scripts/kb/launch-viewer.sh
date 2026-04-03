#!/usr/bin/env bash
# Launch repoview to browse a knowledge base wiki
# Usage: ./scripts/kb/launch-viewer.sh [topic-name]
#   If no topic given, opens the kb/ root directory

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
KB_ROOT="$PROJECT_ROOT/kb"

if [ ! -d "$KB_ROOT" ]; then
  echo "Error: No kb/ directory found. Run /kb-init first."
  exit 1
fi

TOPIC="${1:-}"

if [ -n "$TOPIC" ]; then
  TARGET="$KB_ROOT/$TOPIC/wiki"
  if [ ! -d "$TARGET" ]; then
    echo "Error: Topic '$TOPIC' not found. Available topics:"
    ls -1 "$KB_ROOT" | grep -v '^\.' | grep -v 'README'
    exit 1
  fi
else
  TARGET="$KB_ROOT"
fi

# Check if repoview is available
if command -v repoview &>/dev/null; then
  repoview "$TARGET"
elif command -v npx &>/dev/null; then
  echo "repoview not found globally, trying npx..."
  npx repoview "$TARGET"
else
  echo "repoview not found. Install with: npm install -g repoview"
  echo "Or browse directly: $TARGET"
  exit 1
fi
