# Project Roadmap

A skill for creating and managing a project ROADMAP at the user story level. Use it to define milestones (`HU-*`), their descriptions, and dependencies — without mixing in implementation details.

## Overview

The skill maintains a single file, `.project/ROADMAP.md`, as the source of truth for project planning. It combines a Mermaid dependency diagram with per-story sections so the team can see what will be built and in what order.

Key properties:

- Milestones are numbered incrementally (`HU-1`, `HU-2`, …).
- Dependencies between stories are expressed as `-->` arrows in the Mermaid diagram.
- The file never records status (pending / in-progress / done) — that belongs in issue trackers or task boards.
- Scripts keep the file consistent; the ROADMAP is never edited by hand to add a HU.

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill project-roadmap

# Using bunx
bunx skills add jondotsoy/skills --skill project-roadmap
```

## Usage

### Listing existing milestones

```bash
bash scripts/list-hus.sh .project/ROADMAP.md
```

Output example:

```
- HU-1: Navigable product catalogue
- HU-2: Shopping cart
- HU-3: Checkout with payment
```

### Adding a milestone

```bash
bash scripts/add-hu.sh .project/ROADMAP.md \
  --description "Short milestone description" \
  --body "Paragraph with broader context." \
  --dep HU-1 --dep HU-2   # omit if no dependencies
```

The script auto-assigns the next number, inserts the node in the Mermaid diagram, declares the dependency arrows, and appends the `## HU-N` section. It prints the assigned ID when done.

### ROADMAP structure

```markdown
# ROADMAP

​```mermaid
flowchart TB
  HU-1[HU-1: Short description]
  HU-2[HU-2: Short description]
  HU-3[HU-3: Short description]

  HU-1 --> HU-2
  HU-2 --> HU-3
​```

## HU-1: Short description

Paragraph with a fuller description and any context needed to proceed.

## HU-2: Short description

Paragraph with a fuller description and any context needed to proceed.

## HU-3: Short description

Paragraph with a fuller description and any context needed to proceed.
```

## Scripts

| Script | Usage | Description |
|--------|-------|-------------|
| `scripts/list-hus.sh` | `bash scripts/list-hus.sh <path-ROADMAP>` | Lists all HUs in the format `- HU-N: description`. |
| `scripts/add-hu.sh` | `bash scripts/add-hu.sh <path-ROADMAP> --description <desc> --body <body> [--dep HU-N ...]` | Adds a new HU: inserts the node in the diagram, the dependency arrows, and the `## HU-N` section. |

## Examples

- [tienda-online.md](examples/tienda-online.md) — e-commerce store with 5 milestones and sequential dependencies.
- [plataforma-reportes.md](examples/plataforma-reportes.md) — reporting platform illustrating branching dependencies.

## Documentation

- [SKILL.md](SKILL.md) — Skill definition for AI agents, including the full authoring workflow.
