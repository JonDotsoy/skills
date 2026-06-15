#!/usr/bin/env bash
# Adds a new User Story to the ROADMAP, auto-assigning the next number.
# Inserts the node in the Mermaid diagram, dependency arrows, and the ## HU-N section.
# Usage: add-hu.sh <path-ROADMAP> --description <desc> --body <body> [--dep HU-N ...]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ROADMAP=""
DESCRIPTION=""
BODY=""
DEPS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --description) DESCRIPTION="$2"; shift 2 ;;
    --body)        BODY="$2";        shift 2 ;;
    --dep)         DEPS+=("$2");     shift 2 ;;
    -*)
      echo "Unknown option: $1" >&2; exit 1 ;;
    *)
      if [[ -z "$ROADMAP" ]]; then
        ROADMAP="$1"; shift
      else
        echo "Unexpected argument: $1" >&2; exit 1
      fi ;;
  esac
done

[[ -z "$ROADMAP" ]]     && { echo "Usage: add-hu.sh <path-ROADMAP> --description <desc> --body <body> [--dep HU-N ...]" >&2; exit 1; }
[[ -z "$DESCRIPTION" ]] && { echo "Missing --description" >&2; exit 1; }
[[ -z "$BODY" ]]        && { echo "Missing --body" >&2; exit 1; }

if [[ ! -f "$ROADMAP" ]]; then
  printf '# ROADMAP\n\n```mermaid\nflowchart TB\n```\n' > "$ROADMAP"
fi

python3 - "$ROADMAP" "$DESCRIPTION" "$BODY" "${DEPS[@]}" <<'PYTHON'
import re, sys

roadmap_path = sys.argv[1]
description  = sys.argv[2]
body         = sys.argv[3]
deps         = sys.argv[4:]

with open(roadmap_path) as f:
    content = f.read()

nums  = [int(m.group(1)) for m in re.finditer(r'^## HU-(\d+):', content, re.MULTILINE)]
n     = max(nums, default=0) + 1
hu_id = f"HU-{n}"

def update_mermaid(m):
    opening = m.group(1)
    inner   = m.group(2)
    closing = m.group(3)

    lines          = inner.rstrip('\n').split('\n')
    direction_line = lines[0]
    node_lines     = []
    arrow_lines    = []

    for line in lines[1:]:
        s = line.strip()
        if re.match(r'HU-\d+\[', s):
            node_lines.append(line)
        elif '-->' in s:
            arrow_lines.append(line)

    node_lines.append(f"  {hu_id}[{hu_id}: {description}]")
    for dep in deps:
        arrow_lines.append(f"  {dep} --> {hu_id}")

    rebuilt = [direction_line, ''] + node_lines
    if arrow_lines:
        rebuilt += [''] + arrow_lines
    rebuilt.append('')

    return opening + '\n'.join(rebuilt) + closing

content = re.sub(r'(```mermaid\n)(.*?)(```)', update_mermaid, content, flags=re.DOTALL)

section = f"\n## {hu_id}: {description}\n\n{body}\n"
content = content.rstrip('\n') + '\n' + section

with open(roadmap_path, 'w') as f:
    f.write(content)

print(hu_id)
PYTHON
