# Runbook Generator

A skill for creating structured, reproducible runbooks to document technical procedures, API workflows, and user interface flows.

## Overview

The Runbook Generator helps teams create standardized documentation for reproducible scenarios. Unlike execution logs or one-time procedures, runbooks are designed to be executed multiple times with consistent results. They're perfect for:

- Documenting API workflows and integration testing
- Recording user interface flows and interactions
- Standardizing deployment and operational procedures
- Creating reproducible test scenarios
- Onboarding new team members with clear procedures

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill "Runbook Generator"

# Using bunx
bunx skills add jondotsoy/skills --skill "Runbook Generator"
```

## Usage

### Creating a New Runbook

Use the provided script to generate a runbook from the template:

```bash
./runbook-generator/scripts/create-runbook.sh runbooks/my-scenario
```

This creates a new runbook at `./runbooks/my-scenario/STEPS.md` with the standard structure.

### Runbook Structure

Each runbook follows this format:

1. **Overview** - What this runbook accomplishes
2. **Technical Requirements** - Environment setup and prerequisites
3. **Steps to Reproduce** - Clear, actionable instructions
4. **Validations** - How to verify success

### Example Runbook Scenarios

- User authentication flows
- Payment processing workflows
- API integration testing
- Database migration procedures
- Feature flag configurations
- Deployment procedures

### File Organization

Default structure:
```
./runbooks/
├── user-login-flow/
│   └── STEPS.md
├── api-payment-flow/
│   └── STEPS.md
└── deployment-procedure/
    └── STEPS.md
```

## Documentation

- [SKILL.md](SKILL.md) - Skill definition for AI agents
- [Template](assets/runbook-template.md) - Base template for runbooks
- [Creation Script](scripts/create-runbook.sh) - Script to generate new runbooks
