#!/bin/bash
# Activation script for runbook HTTP scripts
# Usage: source ./scripts/activation.sh
#
# This script sets up the environment for executing HTTP requests:
# - Loads environment variables from .env file
# - Creates the script-http alias for saving responses automatically
#
# Important: All scripts must be executed under supervision.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESPONSES_DIR="$SCRIPT_DIR/responses"

# Create responses directory if it doesn't exist
mkdir -p "$RESPONSES_DIR"

# Load .env file if it exists
if [ -f "$SCRIPT_DIR/.env" ]; then
    echo "Loading environment variables from .env"
    set -a
    source "$SCRIPT_DIR/.env"
    set +a
fi

# Function to execute HTTP requests and save responses
script-http() {
    local TIMESTAMP=$(date +%s)
    local METHOD="${1:-GET}"
    local URL="$2"

    # Extract endpoint name from URL for filename
    local ENDPOINT_NAME=$(echo "$URL" | sed 's|https\?://||' | sed 's|[/:.]|-|g' | cut -c1-50)
    local RESPONSE_FILE="$RESPONSES_DIR/${TIMESTAMP}-${ENDPOINT_NAME}.httpie.http"

    echo "Executing: http $@"
    echo "Response file: $RESPONSE_FILE"
    echo ""

    http "$@" -v 2>&1 | tee "$RESPONSE_FILE"

    echo ""
    echo "Response saved to: $RESPONSE_FILE"
}

# Export the function so it's available in subshells
export -f script-http
export RESPONSES_DIR

echo "Activation complete!"
echo "  - RESPONSES_DIR: $RESPONSES_DIR"
echo "  - Use 'script-http' instead of 'http' to save responses automatically"
echo ""
echo "Example:"
echo "  script-http POST localhost:8080/auth/login username=test password=secret"
