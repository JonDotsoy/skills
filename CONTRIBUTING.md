# 🤝 Contributing to Skills

Welcome! Thank you for your interest in contributing to this project. This repository contains a collection of skills that can be installed in your own projects using command-line tools.

**[Español](CONTRIBUTING-ES.md)**

## 📦 Installing Skills

Users can install skills from this repository using:

```bash
# Install all skills
npx skills add jondotsoy/skills

# Install a specific skill using the folder name
npx skills add jondotsoy/skills --skill coaching-reporter
npx skills add jondotsoy/skills --skill runbook-generator

# With bunx
bunx skills add jondotsoy/skills --skill runbook-executor
```

## ✨ How to Contribute a New Skill

### 1. Skill Naming Convention

The skill name must follow the pattern: **`[role/entity]-[function]`**

- **Role/Entity**: The domain or context of the skill
- **Function**: The action or capability it provides

**Examples:**
- `coaching-reporter` → Coaching + Reporter (generates reports)
- `runbook-generator` → Runbook + Generator (creates runbooks)
- `runbook-executor` → Runbook + Executor (executes runbooks)
- `devops-argocd-cli` → DevOps + ArgoCD CLI (command-line tools)
- `frontend-component-generator` → Frontend + Component Generator

**Format:**
- Use lowercase
- Separate words with hyphens (`-`)
- Be descriptive but concise

### 2. Create the Skill Structure

Create a folder in the project root following the naming convention:

```
your-skill-name/
├── SKILL.md          ← Main file (required)
├── README.md         ← User documentation (required)
├── AGENTS.md         ← Detailed agent instructions (optional)
├── assets/           ← Templates and resources (optional)
│   └── templates/
└── scripts/          ← Executable scripts (optional)
```

**Note:** Use `assets/` for templates and static resources, and `scripts/` for executable shell scripts or automation tools.

### 3. Create the README.md File

Each skill must include a README.md for human users:

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

The README.md should focus on:
- Technical requirements
- Installation instructions
- Usage examples
- File structure expectations

### 4. Create the SKILL.md File

The `SKILL.md` file is the heart of your skill. It must follow the [Agent Skills](https://skill.md) standard format:

```markdown
---
name: your-skill-name
description: Clear description of what the skill does and when to use it (max 200 chars)
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.0"
dependencies: python>=3.8, pandas>=1.5.0  # Optional
---

## Overview
Detailed description of your skill, its purpose, and use cases.

## Instructions
Step-by-step instructions the agent should follow.

## Examples
Input and expected output examples.

## Resources
References to additional files if any.
```

**Required fields in YAML frontmatter:**
- `name`: Skill folder name using kebab-case (e.g., "coaching-reporter", "runbook-generator")
- `description`: Clear description so the agent knows when to invoke the skill (max 200 characters)
- `license`: License type (use MIT)
- `metadata.author`: Author information in format: Name <email> (url)
- `metadata.version`: Version string (e.g., "1.0")

**Optional fields:**
- `dependencies`: Required software packages

### 5. Best Practices

- **Stay focused**: A skill should solve a specific, repeatable task
- **Clear description**: The agent uses the description to decide when to invoke your skill
- **Include examples**: Help the agent understand what a successful result looks like
- **Start simple**: Begin with basic Markdown instructions before adding complex scripts
- **Additional resources**: If you have a lot of information, create additional files in a `resources/` folder

### 6. Add Additional Resources (Optional)

If your skill needs reference files, templates, or scripts:

```
your-skill/
├── SKILL.md
├── AGENTS.md             ← Detailed instructions (optional)
├── assets/
│   └── templates/        ← Templates and static resources
└── scripts/              ← Executable scripts
    └── setup.sh
```

**Guidelines:**
- Use `assets/` for templates, configuration files, and static resources
- Use `scripts/` for executable shell scripts and automation tools
- Create an `AGENTS.md` file for detailed agent instructions if SKILL.md becomes too long
- Reference these files in your `SKILL.md` so the agent knows when to access them

### 7. Update README.md Files

Add your skill to both `README.md` and `README-ES.md` files in the "Available Skills" section:

**In README.md:**
```markdown
### 📝 Your Skill Name
Brief description of what the skill does.

**Perfect for:**
- Use case 1
- Use case 2
- Use case 3

[View Documentation →](your-skill-name/README.md)
```

**In README-ES.md:**
```markdown
### 📝 Tu Skill Name
Breve descripción de lo que hace el skill.

**Perfecto para:**
- Caso de uso 1
- Caso de uso 2
- Caso de uso 3

[Ver Documentación →](your-skill-name/README.md)
```

### 8. Publish to the Develop Branch

Once your skill is ready:

```bash
git checkout develop
git add your-new-skill/
git add README.md
git commit -m "feat: add skill [skill-name]"
git push origin develop
```

### 9. Share

Done! Now you can share with the community that your skill is available to be downloaded and installed in their projects.

## 🧪 Testing Your Skill

Before publishing, verify:

1. ✅ The skill name follows the `[role/entity]-[function]` convention
2. ✅ The `SKILL.md` has complete and valid metadata
3. ✅ The description clearly reflects when the skill should be used
4. ✅ All referenced files exist in the correct locations
5. ✅ The skill works with example prompts

## 🤖 Working with AI Agents

This project includes an **AGENTS.md** file that provides instructions specifically for AI coding agents. If you're using an AI agent (like Claude, Cursor, or GitHub Copilot) to help create your skill, the agent will automatically read this file to understand the project structure and conventions.

The AGENTS.md file contains:
- Project overview and structure
- Skill naming conventions
- SKILL.md format requirements
- Publishing workflow

Most modern AI coding agents automatically detect and use AGENTS.md files to provide better assistance.

## 📚 Additional Resources

- [Agent Skills Specification](https://skill.md)
- [AGENTS.md Format](https://agents.md)
- [Official Skills Documentation](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [Skills Examples](https://github.com/anthropics/skills/tree/main/skills)
- [Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

## 🔒 Security Considerations

- Don't include sensitive information (API keys, passwords) in the code
- Review any scripts before adding them
- Clearly document external dependencies

## 💬 Questions?

If you have questions or need help, open an issue in the repository.

---

**Thank you for contributing! 🎉**
