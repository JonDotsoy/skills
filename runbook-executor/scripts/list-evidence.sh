#!/bin/bash

# Runbook Evidence Lister Script
# Lists evidence files ordered by date (newest first)
# Usage: ./list-evidence.sh <runbook-path>
# Example: ./list-evidence.sh runbooks/user-login-flow

set -e

# Check if path argument is provided
if [ -z "$1" ]; then
    echo "Error: Runbook path is required"
    echo "Usage: $0 <runbook-path>"
    echo "Example: $0 runbooks/user-login-flow"
    exit 1
fi

RUNBOOK_PATH="$1"
EVIDENCE_BASE="$RUNBOOK_PATH/evidence"

# Verify runbook exists
if [ ! -d "$RUNBOOK_PATH" ]; then
    echo "Error: Runbook not found at $RUNBOOK_PATH"
    exit 1
fi

# Check if evidence directory exists
if [ ! -d "$EVIDENCE_BASE" ]; then
    echo "No evidence found for this runbook"
    echo "Evidence directory does not exist: $EVIDENCE_BASE"
    exit 0
fi

# Count evidence directories
EVIDENCE_COUNT=$(find "$EVIDENCE_BASE" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')

if [ "$EVIDENCE_COUNT" -eq 0 ]; then
    echo "No evidence executions found in $EVIDENCE_BASE"
    exit 0
fi

echo "Evidence executions for: $RUNBOOK_PATH"
echo "Total executions: $EVIDENCE_COUNT"
echo ""
echo "Listing (newest first):"
echo "----------------------------------------"

# List directories sorted by name (reverse order for newest first)
# Format: YYYY-MM-DD-HH-MM
find "$EVIDENCE_BASE" -mindepth 1 -maxdepth 1 -type d | sort -r | while read -r evidence_dir; do
    TIMESTAMP=$(basename "$evidence_dir")
    RESULT_FILE="$evidence_dir/result.md"
    
    # Format timestamp for display
    YEAR=$(echo "$TIMESTAMP" | cut -d'-' -f1)
    MONTH=$(echo "$TIMESTAMP" | cut -d'-' -f2)
    DAY=$(echo "$TIMESTAMP" | cut -d'-' -f3)
    HOUR=$(echo "$TIMESTAMP" | cut -d'-' -f4)
    MINUTE=$(echo "$TIMESTAMP" | cut -d'-' -f5)
    
    FORMATTED_DATE="$YEAR-$MONTH-$DAY $HOUR:$MINUTE"
    
    # Check if result.md exists
    if [ -f "$RESULT_FILE" ]; then
        # Try to extract status from the evidence file (handles **Status**: format)
        STATUS=$(grep -m 1 "\*\*Status\*\*:" "$RESULT_FILE" 2>/dev/null | sed 's/.*\*\*Status\*\*:[[:space:]]*//' | tr -d '\r' || echo "Unknown")
        
        # If status is empty or just whitespace, set to "Not Set"
        if [ -z "$STATUS" ] || [ "$STATUS" = " " ]; then
            STATUS="Not Set"
        fi
        
        echo "📋 $FORMATTED_DATE"
        echo "   Path: $evidence_dir"
        echo "   Status: $STATUS"
        
        # Count additional files in the evidence directory
        FILE_COUNT=$(find "$evidence_dir" -type f ! -name "result.md" | wc -l | tr -d ' ')
        if [ "$FILE_COUNT" -gt 0 ]; then
            echo "   Attachments: $FILE_COUNT file(s)"
        fi
        echo ""
    else
        echo "⚠️  $FORMATTED_DATE"
        echo "   Path: $evidence_dir"
        echo "   Status: Missing result.md"
        echo ""
    fi
done

echo "----------------------------------------"
echo "To view a specific execution:"
echo "cat $EVIDENCE_BASE/<timestamp>/result.md"
