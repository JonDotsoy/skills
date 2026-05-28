---
name: issue-workspace
description: Sets up a full development workspace for a GitHub issue: downloads and analyzes the ticket, creates a dedicated branch, configures memory tracking in CLAUDE.md, and prepares a clean PR worktree. Use when starting work on an issue or preparing a pull request.
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.0"
---

# Issue Workspace

## Overview

This skill creates and manages a structured development environment around a single issue/ticket. It sets up memory tracking, isolates changes in a dedicated branch, and prepares a clean worktree for pull request submission — without ever publishing, deploying, or altering remote history.

## Important Restrictions

- ❌ **DO NOT** push any branch under any circumstance — the user always pushes manually
- ❌ **DO NOT** create or modify pull requests
- ❌ **DO NOT** modify GitHub issues or remote history
- ❌ **DO NOT** deploy or publish anything
- ✅ **ALWAYS** create work on an isolated `local/issue/<number>` branch
- ✅ **ALWAYS** keep `.memory/` contents out of the PR worktree
- ✅ **ALWAYS** confirm the base branch before creating anything
- ✅ **ALWAYS** create `.memory/.gitignore` (not root `.gitignore`) to exclude `worktree/`

---

## Commands

### `setup` — Initialize workspace for an issue

Triggered by phrases like:
- "load ticket 123"
- "work on issue 123"
- "setup workspace for issue 123"
- "start working on #456"
- "open ticket ABC-123"

### `prepare-pr` — Prepare the PR worktree

Triggered by phrases like:
- "prepare the PR"
- "ready the pull request"
- "sync to PR branch"
- "update the PR worktree"

---

## Command: `setup`

### Step 1 — Detect current project

```bash
# Repository root
git rev-parse --show-toplevel

# Current base branch (prefer develop, then main, then master)
git remote show origin | grep "HEAD branch"
# or: git symbolic-ref refs/remotes/origin/HEAD
```

Identify the **base branch** (typically `develop`, `main`, or `master`). Store it for later use.

### Step 2 — Download the ticket

For GitHub issues:
```bash
gh issue view <issue-number> --json number,title,body,labels,assignees,state
```

For Linear or other trackers, ask the user to paste the ticket content if no CLI is available.

Parse and extract:
- Issue number
- Title (clean, no special characters)
- Body / description
- Labels

### Step 3 — Create the work branch

```bash
git checkout <base-branch>
git pull origin <base-branch>
git checkout -b local/issue/<issue-number>
```

Branch naming: always `local/issue/<issue-number>` (e.g., `local/issue/42`).

### Step 4 — Create the `.memory/` directory

```bash
mkdir -p .memory
```

Create the following files inside `.memory/`:

**`.memory/context.md`** — ticket analysis (see template at `assets/templates/context.md`):
- Issue number and title
- Full description
- Goal analysis: what problem is being solved
- Key constraints and notes
- Links to related issues or docs

**`.memory/MEMORY.md`** — memory index (starts empty, updated as work progresses):
```markdown
# Memory Index — Issue #<number>

<!-- Entries added automatically as work progresses -->
```

**`.memory/create-pull-request.sh`** — copy from `scripts/create-pull-request.sh` and replace placeholders:
- `{{BASE_BRANCH}}` → detected base branch
- `{{ISSUE_NUMBER}}` → issue number
- `{{ISSUE_TITLE_SLUG}}` → slugified title (lowercase, hyphens, max 40 chars)

Make the script executable:
```bash
chmod +x .memory/create-pull-request.sh
```

Create `.memory/.gitignore` to exclude the worktree folder:
```
worktree/
```

### Step 5 — Update CLAUDE.md

Append the following block to the project's `CLAUDE.md` (create it if it doesn't exist):

```markdown
## Issue Workspace — #<issue-number>

| Setting | Value |
|---------|-------|
| Issue | #<issue-number>: <issue-title> |
| Branch | `local/issue/<issue-number>` |
| Base Branch | `<base-branch>` |
| Memory Location | `.memory/` |

### Memory Instructions

- **Read** memories from `.memory/*.md` at the start of each session
- **Write** new memory files to `.memory/` as work progresses — capture decisions, constraints, discoveries, and blockers
- Memory file naming: `<topic>.md` (e.g., `api-design.md`, `blockers.md`, `test-notes.md`)
- Keep `.memory/MEMORY.md` updated with one-line entries pointing to each memory file
- Memory files in `.memory/` are **not** included in the pull request — they stay on the dev branch only
```

### Step 6 — Confirm setup to the user

Report:
- Branch created: `local/issue/<number>`
- Base branch: `<base-branch>`
- Memory folder: `.memory/`
- Ticket summary (title + one-line goal)
- Next step hint: "Run `.memory/create-pull-request.sh` when ready to prepare the PR"

---

## Command: `prepare-pr`

### Step 1 — Verify workspace is initialized

Check that:
- Current branch is `local/issue/<number>`
- `.memory/` directory exists
- `.memory/create-pull-request.sh` exists

If any of these are missing, abort and tell the user to run `setup` first.

### Step 2 — Run the PR preparation script

```bash
bash .memory/create-pull-request.sh
```

The script (defined below) handles everything. Report its output to the user.

---

## Script: `create-pull-request.sh`

Full logic defined in `scripts/create-pull-request.sh`.

The script does the following:

1. **Reads configuration** from its embedded variables (set during `setup`)
2. **Determines the PR branch name**: `feat/issue-<number>/<title-slug>`
3. **Ensures the PR branch exists**, creating from `<base-branch>` if needed
4. **Ensures the worktree exists** at `.memory/worktree/`, adding it if needed:
   ```bash
   git worktree add .memory/worktree/ <pr-branch>
   ```
5. **Applies code changes** from `local/issue/<number>` into the PR branch:
   - Gets list of commits on dev branch not in base branch
   - Cherry-picks only commits that touch non-memory files
   - Alternatively, applies the diff directly and creates a clean commit
6. **Excludes** `.memory/` from all changes applied to the PR branch
7. **Reports** status: commits applied, files changed, worktree path

---

## File Templates

Reference files in `assets/templates/`:

- `context.md` — ticket context template
- `create-pull-request.sh` — PR preparation script template (also at `scripts/create-pull-request.sh`)

---

## Directory Structure After Setup

```
<project-root>/
├── CLAUDE.md                         ← updated with workspace block
└── .memory/
    ├── .gitignore                    ← contains: worktree/
    ├── MEMORY.md                     ← memory index
    ├── context.md                    ← ticket analysis
    ├── create-pull-request.sh        ← PR prep script
    └── worktree/                     ← git worktree (PR branch, gitignored by .memory/.gitignore)
        └── <code files only>
```

---

## Resources

- Context template: `assets/templates/context.md`
- PR script template: `scripts/create-pull-request.sh`
