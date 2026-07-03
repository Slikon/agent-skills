#!/usr/bin/env bash
# Symlink every skill in ./skills into your Claude Code skills directory.
# Override the target with CLAUDE_SKILLS_DIR (e.g. a project's .claude/skills).
set -euo pipefail

SRC="$(cd "$(dirname "$0")/skills" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mkdir -p "$DEST"
for dir in "$SRC"/*/; do
  name="$(basename "$dir")"
  ln -sfn "$dir" "$DEST/$name"
  echo "linked $name -> $DEST/$name"
done

echo "Done. Restart Claude Code to pick up the skills."
