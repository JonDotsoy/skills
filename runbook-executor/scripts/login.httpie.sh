#!/bin/bash
# Login API request using httpie
# Usage: source ./activation.sh && ./login.httpie.sh
#
# Important: Run 'source ./activation.sh' first to load environment and aliases.

set -e

BASE_URL="${API_BASE_URL:-https://api.example.com}"

script-http POST "$BASE_URL/login" \
    username="${API_USERNAME:-test@example.com}" \
    password="${API_PASSWORD:-secret123}"
