# Commit Message

Generates commit messages following the Conventional Commits standard by reading the staged diff and recent commit history.

## Overview

The Commit Message skill automates writing consistent commit messages by:
- Reading the current staged diff with `git diff --staged`
- Analyzing recent commits to infer the project's style and vocabulary
- Selecting the appropriate type, scope, and subject
- Validating the generated message against Conventional Commits rules before presenting it

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill commit-message

# Using bunx
bunx skills add jondotsoy/skills --skill commit-message
```

## Usage

Invoke the skill after staging your changes:

```bash
git add <files>
/commit-message
```

Or ask your AI assistant:
```
"Generate a commit message"
"Write a commit for these changes"
"What should my commit message be?"
```

### Prerequisites

- A git repository with at least one staged change (`git add` first)
- No additional tools required

## Output Format

```
<type>(<scope>): <subject>

<body>
```

The scope and body are optional. Example outputs:

```
feat(api): add last_payment_folio field to PDF parser

Kastor started including the folio number in boletas issued from 2025-07.
Added extraction logic in parsear_metadata() and updated schema.json.
```

```
fix(consola): show correct billing period when month is January

Date arithmetic was rolling back to December of the previous year
due to a zero-index month offset.
```

```
chore: update wrangler to 3.78.0
```

## Commit Types

| Type | When to use |
|------|-------------|
| `feat` | New functionality visible to the user or system |
| `fix` | Bug fix |
| `refactor` | Internal change that does not alter behavior or add features |
| `test` | Adds or fixes tests |
| `docs` | Documentation only (README, comments) |
| `chore` | Maintenance tasks: dependencies, configuration, CI |
| `style` | Formatting, spacing, naming — no logic change |
| `perf` | Performance optimization |
| `build` | Build system, packaging scripts |
| `ci` | CI/CD pipelines |
| `revert` | Reverts a previous commit |

## Subject Rules

- Imperative mood in English or Spanish, matching the project's recent commits
- Lowercase, no trailing period
- Maximum 72 characters including `type(scope): `
- Describes **what** the change does, not how

## Body Rules

- Separated from the subject by a blank line
- Explains the **why**: context, problem solved, decision made
- Maximum 72 characters per line
- May use bullet points (`-`)
- Omit if the subject is self-explanatory

## Validation

The skill validates every generated message using `scripts/validate-commit-message.sh` before presenting it. The script checks:

1. Subject matches `<type>(<scope>): <description>` or `<type>: <description>`
2. Type is one of the 11 valid types
3. Subject is at most 72 characters
4. Subject has no trailing period
5. Line 2 is blank when a body is present
6. Body lines are at most 72 characters each

Run the validator manually:

```bash
bash scripts/validate-commit-message.sh "feat(api): add endpoint"

# Or via stdin
echo "feat: update deps" | bash scripts/validate-commit-message.sh
```

Run the test suite:

```bash
bash tests/validate-commit-message.test.sh
```

## Documentation

- [SKILL.md](SKILL.md) - Full skill workflow and instructions
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit format specification

## License

MIT

## Author

Jonathan Delgado <hi@jon.soy> (https://jon.soy)
