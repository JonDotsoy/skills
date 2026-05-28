# issue-workspace

Sets up a complete, isolated development environment for a single GitHub issue. Downloads and analyzes the ticket, creates a dedicated branch, wires up memory tracking in `CLAUDE.md`, and prepares a clean worktree for pull request submission.

## Overview

When you start working on a ticket, this skill handles the boilerplate:

- Downloads the issue from GitHub and analyzes it
- Creates a `local/issue/<number>` branch off the detected base branch
- Creates a `.memory/` folder with a ticket context file and a memory index
- Updates `CLAUDE.md` so the agent reads and writes memories from `.memory/` automatically
- Places a `create-pull-request.sh` script in `.memory/` to prepare the PR worktree when you're ready

When you finish coding and want to open a PR, it:

- Creates a clean `feat/issue-<number>/<slug>` branch from the base branch
- Sets up a git worktree at `.memory/worktree/` (gitignored)
- Applies only code commits to the PR branch, keeping memory files out
- Leaves the PR branch ready for review — no publishing, no pushing

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill issue-workspace

# Using bunx
bunx skills add jondotsoy/skills --skill issue-workspace
```

## Usage

### Start working on an issue

```
load ticket 123
work on issue 456
setup workspace for issue ABC-789
start working on #42
```

The skill will:
1. Fetch and analyze the ticket
2. Create `local/issue/42` branch
3. Set up `.memory/` with context and memory index
4. Update `CLAUDE.md` with memory instructions

### Prepare a pull request

```
prepare the PR
ready the pull request
sync to PR branch
```

The skill runs `.memory/create-pull-request.sh`, which:
1. Creates `feat/issue-42/<title-slug>` branch from base
2. Adds a git worktree at `.memory/worktree/`
3. Cherry-picks code commits (excluding `.memory/`) into the PR branch

## File Structure

```
<project-root>/
├── CLAUDE.md                         ← issue workspace block appended here
└── .memory/
    ├── .gitignore                    ← contains: worktree/
    ├── MEMORY.md                     ← memory index (auto-updated)
    ├── context.md                    ← ticket analysis and work log
    ├── create-pull-request.sh        ← PR preparation script
    └── worktree/                     ← git worktree for PR branch (gitignored)
```

## What This Skill Does NOT Do

- **Push branches** — the user always pushes manually, never the skill
- Create or modify pull requests
- Deploy or publish anything
- Modify GitHub issues or remote history

Use the `pr-creator` skill after `prepare-pr` to actually open the pull request.

## Documentation

- [SKILL.md](SKILL.md) — agent instructions
- [scripts/create-pull-request.sh](scripts/create-pull-request.sh) — PR prep script template
- [assets/templates/context.md](assets/templates/context.md) — ticket context template
