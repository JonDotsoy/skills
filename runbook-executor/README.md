# Runbook Executor

A skill for executing runbooks and generating timestamped evidence documentation of execution results.

## Overview

The Runbook Executor complements the Runbook Generator by providing a structured way to document runbook executions. Each time a runbook is executed, this skill creates a timestamped evidence file that captures:

- What actually happened during execution
- Actual commands run and their outputs
- Validation results and comparisons
- Issues encountered and their resolutions
- Deviations from the documented procedure
- Screenshots and logs as attachments

This creates an audit trail of runbook executions, making it easy to:
- Track execution history over time
- Compare expected vs actual results
- Identify patterns in failures or issues
- Improve runbook documentation based on real executions
- Provide evidence for compliance or debugging

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill runbook-executor

# Using bunx
bunx skills add jondotsoy/skills --skill runbook-executor
```

## Usage

### Creating Evidence for a Runbook Execution

Use the provided script to generate an evidence file:

```bash
./runbook-executor/scripts/create-evidence.sh runbooks/user-login-flow
```

This creates a timestamped evidence file at:
```
./runbooks/user-login-flow/evidence/2026-01-31-14-30/result.md
```

### Listing Evidence Executions

View all evidence executions for a runbook, ordered by date (newest first):

```bash
./runbook-executor/scripts/list-evidence.sh runbooks/user-login-flow
```

Output example:
```
Evidence executions for: runbooks/user-login-flow
Total executions: 3

Listing (newest first):
----------------------------------------
📋 2026-01-31 14:30
   Path: runbooks/user-login-flow/evidence/2026-01-31-14-30
   Status: Success
   Attachments: 2 file(s)

📋 2026-01-31 09:15
   Path: runbooks/user-login-flow/evidence/2026-01-31-09-15
   Status: Failed
   Attachments: 1 file(s)

📋 2026-01-30 16:45
   Path: runbooks/user-login-flow/evidence/2026-01-30-16-45
   Status: Success
```

### Evidence File Structure

Each evidence file includes:

1. **Execution Summary** - Status, duration, environment
2. **Prerequisites Verification** - Checklist of setup requirements
3. **Step-by-Step Execution** - Detailed documentation of each step
4. **Validation Results** - Database, API, and UI checks
5. **Issues Encountered** - Problems and their resolutions
6. **Deviations** - Differences from the runbook
7. **Recommendations** - Improvement suggestions
8. **Conclusion** - Overall assessment

### Workflow Example

1. User wants to execute a runbook and document it
2. Run: `./runbook-executor/scripts/create-evidence.sh runbooks/api-test`
3. Follow the steps in `runbooks/api-test/STEPS.md`
4. Document each step's execution in the generated evidence file
5. Add screenshots or logs to the evidence directory
6. Complete validations and write conclusion

### File Organization

```
./runbooks/
└── user-login-flow/
    ├── STEPS.md
    └── evidence/
        ├── 2026-01-31-09-15/
        │   ├── result.md
        │   └── screenshot1.png
        ├── 2026-01-31-14-30/
        │   ├── result.md
        │   └── api-response.json
        └── 2026-02-01-10-00/
            └── result.md
```

## HTTP Request Scripts

For runbooks that include HTTP API calls, use **httpie** scripts to automate requests and save responses:

### Creating HTTP Scripts

Create scripts in your runbook's `scripts/` directory:

```bash
./runbooks/api-test/
├── STEPS.md
├── scripts/
│   ├── login.httpie.sh
│   └── responses/
│       └── 1738500000-login.httpie.http
└── evidence/
```

### Example httpie Script

```bash
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RESPONSES_DIR="$SCRIPT_DIR/responses"
TIMESTAMP=$(date +%s)

mkdir -p "$RESPONSES_DIR"

http POST https://api.example.com/login \
    username=test@example.com \
    password=secret123 \
    -v 2>&1 | tee "$RESPONSES_DIR/${TIMESTAMP}-login.httpie.http"
```

### Response File Naming

Use Unix timestamps for unique filenames:
```
<timestamp>-<endpoint>.httpie.http
```

An example script is included at `scripts/login.httpie.sh`.

## Use Cases

- Documenting API integration testing
- Recording UI flow executions
- Creating audit trails for compliance
- Debugging production issues
- Training new team members
- Comparing execution results over time

## Documentation

- [SKILL.md](SKILL.md) - Skill definition for AI agents
- [Template](assets/evidence-template.md) - Base template for evidence files
- [Creation Script](scripts/create-evidence.sh) - Script to generate evidence files
- [List Script](scripts/list-evidence.sh) - Script to list evidence executions by date
