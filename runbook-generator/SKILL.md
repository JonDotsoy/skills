---
name: runbook-generator
description: Creates structured runbooks to document reproducible scenarios for APIs, UX flows, and technical procedures
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.1"
---

# Overview

This skill helps create standardized runbooks that document reproducible scenarios in a clear, step-by-step format. Runbooks are ideal for documenting API workflows, user interface flows, deployment procedures, and any technical process that needs to be executed consistently.

A runbook is a living document that describes an ideal, reproducible scenario - not a log of past executions. It should be executable multiple times with the same expected results.

# Configuration

Default runbook location: `./runbooks/<task-name>/STEPS.md`

You can customize the runbook path when creating a new runbook.

# Runbook Structure

Each runbook must include:

1. **Overview**: Brief description of what this runbook accomplishes
2. **Technical Requirements**: Environment setup needed before execution
   - Git branch/commit to checkout
   - Database state requirements
   - Required credentials or configurations
   - Environment context (local, dev, staging, prod)
   - Any pre-execution setup (delete records, modify configs, etc.)
3. **Steps to Reproduce**: Clear, actionable steps
   - Exact commands to run
   - UI elements to click
   - API calls to make (with curl examples)
   - Expected responses at each step
4. **Validations**: How to verify successful completion
   - Database queries to run
   - UI states to check
   - API responses to validate
   - Success criteria

# Instructions

When asked to create a runbook:

1. Run the creation script: `./runbook-generator/scripts/create-runbook.sh <runbook-path>`
2. Edit the generated template with specific details
3. Ensure all sections are complete and actionable
4. Verify the runbook is reproducible

When asked to update a runbook:

1. Locate the existing STEPS.md file
2. Update the relevant sections
3. Maintain the standard structure

# Examples

Create a runbook for user login flow:
```bash
./runbook-generator/scripts/create-runbook.sh runbooks/user-login-flow
```

Create a runbook for API endpoint testing:
```bash
./runbook-generator/scripts/create-runbook.sh runbooks/api-payment-flow
```

# HTTP Request Scripts

When a runbook contains HTTP requests that can be executed locally, create scripts using **httpie** to automate the requests and save responses.

> **Important**: All scripts must be executed under supervision. Review each script before execution and verify the target endpoints are correct for your environment.

## Structure for HTTP Scripts

```
<runbook-path>/
├── STEPS.md
├── scripts/
│   ├── login.httpie.sh
│   ├── get-user.httpie.sh
│   └── responses/
│       ├── 1738500000-login.httpie.http
│       └── 1738500100-get-user.httpie.http
└── evidence/
```

## Script Requirements

Each httpie script should:

1. Use httpie with `-v` flag for verbose output
2. Save responses to `scripts/responses/` directory
3. Use Unix timestamp in the filename
4. Include clear documentation

## Naming Convention

Response files follow this pattern:
```
<unix-timestamp>-<endpoint-name>.httpie.http
```

## Example httpie Script

```bash
#!/bin/bash
# Login API request using httpie

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RESPONSES_DIR="$SCRIPT_DIR/responses"
TIMESTAMP=$(date +%s)

mkdir -p "$RESPONSES_DIR"

http POST https://api.example.com/login \
    username=test@example.com \
    password=secret123 \
    -v 2>&1 | tee "$RESPONSES_DIR/${TIMESTAMP}-login.httpie.http"

echo "Response saved to: $RESPONSES_DIR/${TIMESTAMP}-login.httpie.http"
```

## STEPS.md Integration

When documenting HTTP steps in `STEPS.md`, reference the scripts:

```markdown
## Step 3: Authenticate with API

Execute the login script to authenticate:

\`\`\`bash
./scripts/login.httpie.sh
\`\`\`

Expected response: HTTP 200 with JWT token in response body.
Response saved to: `scripts/responses/<timestamp>-login.httpie.http`
```

# Resources

- Template: `assets/runbook-template.md`
- Creation script: `scripts/create-runbook.sh`
