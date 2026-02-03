---
name: runbook-executor
description: Executes runbooks and generates timestamped evidence documentation of the execution results
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.1"
---

# Overview

This skill helps execute runbooks and document the execution with timestamped evidence. When a user runs through a runbook's steps, this skill generates a structured evidence file that captures what actually happened during execution, including results, deviations, issues, and validations.

Evidence files are stored alongside the runbook in timestamped directories, allowing multiple executions to be tracked over time without overwriting previous evidence.

# Configuration

Evidence location pattern: `<runbook-path>/evidence/<YYYY-MM-DD-HH-MM>/result.md`

Example: `./runbooks/user-login-flow/evidence/2026-01-31-14-30/result.md`

# Evidence Structure

Each evidence file documents:

1. **Execution Summary**: Status, duration, environment, executor
2. **Technical Requirements Verification**: Confirmation of prerequisites
3. **Step-by-Step Execution**: Actual commands run, results obtained, timestamps
4. **Validation Results**: Database checks, API responses, UI verifications
5. **Issues Encountered**: Problems found and their resolutions
6. **Deviations**: Any differences from the documented runbook
7. **Recommendations**: Suggestions for improving the runbook
8. **Conclusion**: Overall assessment and follow-up actions

# Instructions

When asked to execute a runbook and document evidence:

1. Run the evidence creation script: `./runbook-executor/scripts/create-evidence.sh <runbook-path>`
2. Follow the runbook steps in `<runbook-path>/STEPS.md`
3. Document each step's execution in the generated evidence file
4. Capture actual commands, outputs, and results
5. Note any deviations or issues encountered
6. Complete all validation sections
7. Add screenshots or logs to the evidence directory if needed
8. Write the conclusion with overall assessment

When asked to review past executions:

1. Run the list script: `./runbook-executor/scripts/list-evidence.sh <runbook-path>`
2. Review the list of executions ordered by date (newest first)
3. Open the relevant `result.md` file from the desired timestamp

# Examples

Execute a runbook and create evidence:
```bash
./runbook-executor/scripts/create-evidence.sh runbooks/user-login-flow
```

Execute an API testing runbook:
```bash
./runbook-executor/scripts/create-evidence.sh runbooks/api-payment-flow
```

List all evidence executions for a runbook (newest first):
```bash
./runbook-executor/scripts/list-evidence.sh runbooks/user-login-flow
```

# HTTP Requests in Runbooks

When a runbook contains HTTP requests that can be executed locally, create scripts using **httpie** to automate the requests and save responses for evidence.

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

Examples:
- `1738500000-login.httpie.http`
- `1738500100-get-users.httpie.http`
- `1738500200-create-order.httpie.http`

## Example Script

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

## Common httpie Commands

```bash
# GET request
http GET https://api.example.com/users -v

# POST with JSON body
http POST https://api.example.com/login username=user password=pass -v

# POST with custom headers
http POST https://api.example.com/data \
    Authorization:"Bearer token123" \
    -v

# PUT request
http PUT https://api.example.com/users/1 name="Updated Name" -v

# DELETE request
http DELETE https://api.example.com/users/1 -v
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

- Template: `assets/evidence-template.md`
- Creation script: `scripts/create-evidence.sh`
- List script: `scripts/list-evidence.sh`
- Example httpie script: `scripts/login.httpie.sh`
