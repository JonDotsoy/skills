# Feature Notes

Keeps a per-branch context sheet (`feature.md`) for the feature currently being worked on.

## Overview

The Feature Notes skill maintains a feature detail file per git branch, stored at `.git/features_works/<branch>/feature.md`. This file is **not an implementation plan for the agent** — it is the feature's context sheet: what is being built, why (business context), and what technical constraints must be respected. The agent uses it as a source of truth to understand the work before touching code, and keeps it updated as the conversation provides more context.

It lives inside `.git/` because it is work-in-progress information specific to this local copy of the repo that the user wants to keep without versioning or sharing. Git never tracks the contents of `.git/`, so there is no need to gitignore it or worry about it ending up in a commit by accident — but it also means it is lost if the user clones the repo again on another machine.

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill feature-notes

# Using bunx
bunx skills add jondotsoy/skills --skill feature-notes
```

## Usage

Ask your AI assistant things like:

```
"What feature are we working on?"
"In this branch let's work on the login redesign"
"Update the feature notes with this new constraint"
"Update the CHANGELOG for the work done on this feature"
```

The skill will:
1. Detect the current git branch (`git branch --show-current`)
2. Create, read, or update `.git/features_works/<branch>/feature.md` as needed
3. Use the file's business context and technical constraints to inform implementation
4. Optionally update the project's `CHANGELOG.md` when explicitly asked, matching its existing format

### Prerequisites

- A git repository (a detached HEAD falls back to `.git/features_works/detached-<hash>/feature.md`)
- No additional tools required

## File Structure

```
.git/features_works/<branch>/feature.md
```

Branch names containing `/` (e.g. `feature/01`) naturally create subfolders (`.git/features_works/feature/01/feature.md`) — this is expected behavior.

The file follows the structure defined in `assets/feature_template.md`:

- **Business context** — why this is being built, what problem it solves, for whom
- **What will be built** — functional description and scope
- **Technical details / constraints** — decisions already made, APIs or libraries to use, things to avoid
- **Open questions** — pending doubts, if any

## Documentation

- [SKILL.md](SKILL.md) - Skill definition
