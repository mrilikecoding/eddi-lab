#!/bin/bash
set -e

# Check for recent workflow failures in a specific repository
# Usage: ./check-repo-failures.sh <repo-path> <repo-display-name>

REPO="$1"
REPO_NAME="$2"

if [ -z "$REPO" ] || [ -z "$REPO_NAME" ]; then
    echo "Usage: $0 <repo-path> <repo-display-name>"
    exit 1
fi

cd "$REPO"

# Look for recent failures
FAILED=$(gh run list --limit 10 --status completed --json conclusion,databaseId,name,createdAt 2>/dev/null | jq -r '.[] | select(.conclusion == "failure") | "\(.databaseId) \(.name)"' 2>/dev/null | head -3 || true)

if [ -n "$FAILED" ]; then
    echo "❌ $REPO_NAME Recent Failures:"
    echo "$FAILED" | sed 's/^/     /'
else
    printf "✅ %-15s No recent failures\n" "$REPO_NAME:"
fi