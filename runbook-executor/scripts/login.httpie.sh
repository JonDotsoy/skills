#!/bin/bash

# Login API request using httpie
# Usage: ./login.httpie.sh [base_url]
#
# This is an example script demonstrating how to make HTTP requests
# and save responses for runbook evidence documentation.
#
# Requirements:
#   - httpie (https://httpie.io/)
#   - Install: pip install httpie or brew install httpie

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RESPONSES_DIR="$SCRIPT_DIR/responses"
TIMESTAMP=$(date +%s)
BASE_URL="${1:-https://api.example.com}"

# Create responses directory if it doesn't exist
mkdir -p "$RESPONSES_DIR"

RESPONSE_FILE="$RESPONSES_DIR/${TIMESTAMP}-login.httpie.http"

echo "Executing login request..."
echo "Target: $BASE_URL/login"
echo ""

# Execute the HTTP request and save the response
# Using -v for verbose output (shows request and response headers)
# Using --print=hHbB to show request headers, request body, response headers, response body
http POST "$BASE_URL/login" \
    username=test@example.com \
    password=secret123 \
    Content-Type:application/json \
    -v 2>&1 | tee "$RESPONSE_FILE"

echo ""
echo "----------------------------------------"
echo "Response saved to: $RESPONSE_FILE"
echo "Timestamp: $TIMESTAMP"
echo "----------------------------------------"
