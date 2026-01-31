#!/bin/bash

# Runbook Evidence Generator Script
# Usage: ./create-evidence.sh <runbook-path>
# Example: ./create-evidence.sh runbooks/user-login-flow

set -e

# Check if path argument is provided
if [ -z "$1" ]; then
    echo "Error: Runbook path is required"
    echo "Usage: $0 <runbook-path>"
    echo "Example: $0 runbooks/user-login-flow"
    exit 1
fi

RUNBOOK_PATH="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_PATH="$SCRIPT_DIR/../assets/evidence-template.md"

# Ensure the template exists
if [ ! -f "$TEMPLATE_PATH" ]; then
    echo "Error: Template not found at $TEMPLATE_PATH"
    exit 1
fi

# Verify runbook exists
if [ ! -f "$RUNBOOK_PATH/STEPS.md" ]; then
    echo "Error: Runbook not found at $RUNBOOK_PATH/STEPS.md"
    echo "Please provide a valid runbook path"
    exit 1
fi

# Generate timestamp directory name
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M")
EVIDENCE_DIR="$RUNBOOK_PATH/evidence/$TIMESTAMP"

# Create the evidence directory
mkdir -p "$EVIDENCE_DIR"

# Copy the template to result.md
cp "$TEMPLATE_PATH" "$EVIDENCE_DIR/result.md"

echo "✓ Evidence file created at: $EVIDENCE_DIR/result.md"
echo ""
echo "Next steps:"
echo "1. Edit $EVIDENCE_DIR/result.md"
echo "2. Document each step execution with actual results"
echo "3. Add screenshots or logs to $EVIDENCE_DIR/"
echo "4. Complete validations and conclusions"
