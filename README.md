# Agent Skills Collection

> A curated collection of AI agent skills for automating documentation, coaching reports, and technical workflows

English | **[Español](README-ES.md)**

## 📖 Overview

This repository contains a collection of Agent Skills that can be installed in projects using command-line tools like `npx skills` or `bunx skills`. Each skill is a self-contained package with instructions and resources that AI agents can use to perform specific tasks.

## Available Skills

### 📊 Coaching Reporter
Transform raw coaching session notes into professional, structured reports automatically.

**Perfect for:**
- Agile Coaches managing multiple coachee sessions
- Scrum Masters tracking team development
- Tech Leads documenting 1-on-1s
- Engineering Managers maintaining coaching documentation

[View Documentation →](coaching-reporter/README.md)

### 📝 Runbook Generator
Create structured runbooks to document reproducible scenarios for APIs, UX flows, and technical procedures.

**Perfect for:**
- Documenting API workflows and integration testing
- Recording user interface flows
- Standardizing deployment procedures
- Creating reproducible test scenarios

[View Documentation →](runbook-generator/README.md)

### ▶️ Runbook Executor
Execute runbooks and generate timestamped evidence documentation of execution results.

**Perfect for:**
- Creating audit trails for compliance
- Debugging production issues
- Training new team members
- Comparing execution results over time

[View Documentation →](runbook-executor/README.md)

## 🚀 Quick Start

### Installation

Add skills to your project using your preferred package manager:

**Install all skills:**
```bash
npx skills add jondotsoy/skills
```

**Install a specific skill:**
```bash
npx skills add jondotsoy/skills --skill coaching-reporter
npx skills add jondotsoy/skills --skill runbook-generator
npx skills add jondotsoy/skills --skill runbook-executor
```

**Using Bun:**
```bash
bunx skills add jondotsoy/skills --skill coaching-reporter
```

## 📚 Documentation

Each skill includes comprehensive documentation:

- **SKILL.md**: Agent instructions and configuration
- **README.md**: User documentation and usage examples
- **AGENTS.md**: Detailed instructions for AI agents (when applicable)

## 🤝 Contributing

Contributions are welcome! Please read the [Contributing Guide](CONTRIBUTING.md) for details on how to create new skills or improve existing ones.

**Contributing in Spanish?** Check out [CONTRIBUTING-ES.md](CONTRIBUTING-ES.md)

## 🛠️ Creating Your Own Skills

Want to create a custom skill? Follow the guidelines in [AGENTS.md](AGENTS.md) to learn about:

- Skill naming conventions
- Required file structure
- SKILL.md format and metadata
- Testing and publishing process

## 📄 License

This project is distributed under the **MIT License**.

See the [LICENSE](./LICENSE) file for complete details.

---

**Made with ❤️ by [Jonathan Delgado](https://jon.soy)**
