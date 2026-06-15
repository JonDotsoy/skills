#!/usr/bin/env bash
# Reads the ROADMAP and lists all defined User Stories.
# Output: one line per HU in the format "- HU-N: short description",
# in the same order they appear in the document.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROADMAP="${1:?Usage: listar-hus.sh <path-to-ROADMAP.md>}"

if [[ ! -f "$ROADMAP" ]]; then
  echo "ROADMAP.md not found" >&2
  exit 1
fi

grep '^## HU-' "$ROADMAP" | sed 's/^## /- /'
