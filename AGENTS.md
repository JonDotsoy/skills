# AGENTS.md

## Project Overview

This repository contains a collection of Agent Skills that can be installed in projects using command-line tools like `npx skills` or `bunx skills`. Each skill is a self-contained folder with instructions and resources that agents can use to perform specific tasks.

## Creating a New Skill

### Skill Naming Convention

Follow the pattern: `[role/entity]-[function]`

Examples:
- `coaching-reporter` (coaching + reporter)
- `devops-argocd-cli` (devops + argocd cli)
- `frontend-component-generator` (frontend + component generator)

Use lowercase and separate words with hyphens.

### Skill Structure

Create a folder in the project root:

```
your-skill-name/
├── SKILL.md          # Required: Main skill file
├── README.md         # Required: User documentation
└── resources/        # Optional: Additional files
    ├── templates/
    └── scripts/
```

### README.md Format

Each skill must include a README.md file with:

```markdown
# Skill Name

Brief description of what the skill does.

## Overview
Detailed explanation of the skill's purpose and capabilities.

## Installation
```bash
# Using npx
npx skills add jondotsoy/skills --skill your-skill-name

# Using bunx
bunx skills add jondotsoy/skills --skill your-skill-name
```

## Usage
Technical details on how to use the skill, file structure, and examples.

## Documentation
- [SKILL.md](SKILL.md) - Skill definition
- [AGENTS.md](AGENTS.md) - Detailed agent instructions (if applicable)
```

The README.md is for human users and should focus on:
- Technical requirements
- Installation instructions
- Usage examples
- File structure expectations

### SKILL.md Format

The SKILL.md file must follow the Agent Skills standard format:

```markdown
---
name: skill-name
description: Clear description of what the skill does (max 200 chars)
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.0"
dependencies: package>=version  # Optional
---

## Overview
Detailed description of the skill's purpose and use cases.

## Instructions
Step-by-step instructions for the agent to follow.

## Examples
Input and expected output examples.

## Resources
References to additional files if needed.
```

Required metadata in frontmatter:
- `name`: Skill folder name using kebab-case (e.g., "coaching-reporter", "runbook-generator")
- `description`: When to use this skill (max 200 characters)
- `license`: License type (use MIT)
- `metadata.author`: Author information in format: Name <email> (url)
- `metadata.version`: Version string (e.g., "1.0")
- `dependencies`: Optional package dependencies

### Publishing Process

1. Create the skill folder with SKILL.md
2. Add resources if needed
3. Update README.md with skill information
4. Commit to the `develop` branch
5. Push changes

```bash
git checkout develop
git add your-skill-name/
git add README.md
git commit -m "feat: add skill [skill-name]"
git push origin develop
```

## Testing

Before committing:
- Verify skill name follows `[role/entity]-[function]` convention
- Ensure SKILL.md has valid YAML frontmatter
- Check all referenced files exist
- Test with example prompts

## Code Style

### Markdown Format

- Use `#` for titles (not `##` or other levels at the top)
- Avoid emojis in skill files
- Keep formatting clean and professional

### SKILL.md Guidelines

- Keep SKILL.md simple and concise
- For detailed instructions, create a separate AGENTS.md file inside the skill folder
- The skill's AGENTS.md provides extended context for AI agents working with that specific skill

Example structure:
```
your-skill-name/
├── SKILL.md          # Simple, high-level instructions
├── AGENTS.md         # Detailed instructions for agents (optional)
└── resources/
```

### General Guidelines

- Keep instructions clear and concise
- Include practical examples
- Reference external files when needed

## Additional Resources

- Agent Skills specification: https://skill.md
- Contributing guide: CONTRIBUTING.md (English) / CONTRIBUTING-ES.md (Español)
