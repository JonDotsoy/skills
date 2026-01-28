# 🤝 Contributing to Skills

Welcome! Thank you for your interest in contributing to this project. This repository contains a collection of skills that can be installed in your own projects using command-line tools.

**[Español](CONTRIBUTING-ES.md)**

## 📦 Installing Skills

Users can install skills from this repository using:

```bash
# With npx
npx skills add jondotsoy/skills --skill coaching-reporter

# With bunx
bunx skills add jondotsoy/skills --skill coaching-reporter
```

## ✨ How to Contribute a New Skill

### 1. Skill Naming Convention

The skill name must follow the pattern: **`[role/entity]-[function]`**

- **Role/Entity**: The domain or context of the skill
- **Function**: The action or capability it provides

**Examples:**
- `coaching-reporter` → Coaching + Reporter (generates reports)
- `devops-argocd-cli` → DevOps + ArgoCD CLI (command-line tools)
- `frontend-component-generator` → Frontend + Component Generator
- `data-analysis-pipeline` → Data Analysis + Pipeline

**Format:**
- Use lowercase
- Separate words with hyphens (`-`)
- Be descriptive but concise

### 2. Create the Skill Structure

Create a folder in the project root following the naming convention:

```
skills/
├── coaching-reporter/
│   ├── SKILL.md          ← Main file (required)
│   └── resources/        ← Additional resources (optional)
│       ├── templates/
│       └── scripts/
```

### 3. Create the SKILL.md File

The `SKILL.md` file is the heart of your skill. It must follow the [Agent Skills](https://skill.md) standard format:

```markdown
---
name: Skill Name
description: Clear description of what the skill does and when to use it (max 200 chars)
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
- `name`: Friendly skill name (max 64 characters)
- `description`: Clear description so the agent knows when to invoke the skill (max 200 characters)

**Optional fields:**
- `dependencies`: Required software packages

### 4. Best Practices

- **Stay focused**: A skill should solve a specific, repeatable task
- **Clear description**: The agent uses the description to decide when to invoke your skill
- **Include examples**: Help the agent understand what a successful result looks like
- **Start simple**: Begin with basic Markdown instructions before adding complex scripts
- **Additional resources**: If you have a lot of information, create additional files in a `resources/` folder

### 5. Add Additional Resources (Optional)

If your skill needs reference files, templates, or scripts:

```
your-skill/
├── SKILL.md
└── resources/
    ├── REFERENCE.md      ← Supplementary information
    ├── templates/        ← Templates
    └── scripts/          ← Executable scripts
```

Reference these files in your `SKILL.md` so the agent knows when to access them.

### 6. Update README.md

Add your skill to the project's `README.md` file. Although there's no established format yet, include:

- Skill name
- Brief description
- Installation example
- Main use cases

### 7. Publish to the Develop Branch

Once your skill is ready:

```bash
git checkout develop
git add your-new-skill/
git add README.md
git commit -m "feat: add skill [skill-name]"
git push origin develop
```

### 8. Share

Done! Now you can share with the community that your skill is available to be downloaded and installed in their projects.

## 🧪 Testing Your Skill

Before publishing, verify:

1. ✅ The skill name follows the `[role/entity]-[function]` convention
2. ✅ The `SKILL.md` has complete and valid metadata
3. ✅ The description clearly reflects when the skill should be used
4. ✅ All referenced files exist in the correct locations
5. ✅ The skill works with example prompts

## 📚 Additional Resources

- [Agent Skills Specification](https://skill.md)
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
