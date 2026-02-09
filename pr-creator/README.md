# PR Creator

Automates the creation of GitHub pull requests in draft mode following Conventional Commits format.

## Overview

The PR Creator skill streamlines the pull request creation process by:
- Automatically pushing the current branch to remote
- Extracting ticket IDs from branch names
- Analyzing code changes with git diff
- Generating structured PR titles following Conventional Commits
- Creating detailed PR descriptions with proper formatting
- Adding appropriate labels based on change type
- Assigning the PR to the creator
- Always creating PRs in draft mode for review

This skill is designed for developers who want to maintain consistency in their PR format while saving time on the creation process.

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill pr-creator

# Using bunx
bunx skills add jondotsoy/skills --skill pr-creator
```

## Usage

Simply invoke the skill when you're ready to create a pull request from your current branch:

```bash
# From your feature branch
/pr-creator
```

Or ask your AI assistant:
```
"Create a PR"
"Make a pull request"
"Open a PR for these changes"
```

### Prerequisites

- GitHub CLI (`gh`) must be installed and authenticated
- Git repository must have a remote configured
- Current branch must not be `main`, `develop`, `master`, or `HEAD`
- Changes should be committed to the current branch

### Branch Naming Conventions

The skill works best with branches that follow these patterns:
- `feat/TICKET-123/description`
- `fix/ABC-456/bug-description`
- `TICKET-789-feature-name`
- `refactor/description` (without ticket)

The ticket ID will be automatically extracted and included in the PR title.

## Output Format

### PR Title Format
```
(TICKET-ID) type(scope): brief description
```

Example:
```
(ABCD-123) fix(profile): handle null enrollment timestamps
```

### PR Body Sections
- 🚀 Overview: Context and purpose
- ✨ Key Features: Main changes
- 🛠️ Changes Made: Technical details
- ✅ Validation & Testing: Test results and commands
- 🔗 Related: Links to tickets and documentation

### Automatic Features
- Draft mode enabled by default
- Auto-assignment to creator (`@me`)
- Smart label selection based on change type
- English language for title and body

## Change Types and Labels

| Type | Label | Use Case |
|------|-------|----------|
| `fix` | `bug` | Bug fixes |
| `feat` | `enhancement`/`feature` | New features |
| `docs` | `documentation` | Documentation updates |
| `refactor` | `refactor` | Code refactoring |
| `test` | `testing` | Test additions |
| `chore` | `maintenance`/`chore` | Maintenance tasks |

## Restrictions

The skill will **NOT**:
- Change the current branch
- Merge any branches
- Close pull requests
- Modify existing code
- Work from protected branches (`main`, `develop`, `master`, `HEAD`)

## Examples

### Creating a PR for a bug fix

```bash
# Your branch: fix/ABCD-123/null-timestamps
# Command: /pr-creator

# Result:
# - Title: (ABCD-123) fix(profile): handle null enrollment timestamps
# - Label: bug
# - Mode: draft
# - Assigned: @me
```

### Creating a PR for a new feature

```bash
# Your branch: feat/ABC-123/user-profile
# Command: /pr-creator

# Result:
# - Title: (ABC-123) feat(profile): add enrollment timestamp to profile response
# - Label: enhancement
# - Mode: draft
# - Assigned: @me
```

### Creating a PR without a ticket

```bash
# Your branch: refactor/simplify-auth
# Command: /pr-creator

# Result:
# - Title: refactor(auth): simplify token validation logic
# - Label: refactor
# - Mode: draft
# - Assigned: @me
```

## Documentation

- [SKILL.md](SKILL.md) - Skill definition and detailed instructions
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit format specification
- [GitHub CLI](https://cli.github.com/) - GitHub CLI documentation

## Troubleshooting

**Issue**: "gh: command not found"
- **Solution**: Install GitHub CLI: `brew install gh` (macOS) or visit [cli.github.com](https://cli.github.com/)

**Issue**: "Permission denied"
- **Solution**: Authenticate with GitHub: `gh auth login`

**Issue**: "Cannot create PR from main/develop"
- **Solution**: Create a feature branch first: `git checkout -b feat/your-feature`

**Issue**: "No commits to create PR"
- **Solution**: Make sure you have committed changes to your branch

## License

MIT

## Author

Jonathan Delgado <hi@jon.soy> (https://jon.soy)
