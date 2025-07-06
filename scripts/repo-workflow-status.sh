#!/bin/bash
set -e

# Show workflow status for a specific repository
# Usage: ./repo-workflow-status.sh <repo-path> <repo-display-name>

REPO="$1"
REPO_NAME="$2"

if [ -z "$REPO" ] || [ -z "$REPO_NAME" ]; then
    echo "Usage: $0 <repo-path> <repo-display-name>"
    exit 1
fi

printf "  %-15s " "$REPO_NAME:"

cd "$REPO"

if LATEST=$(gh run list --limit 1 --json status,conclusion,name,createdAt 2>/dev/null); then
    if [ "$LATEST" = "[]" ]; then
        echo "ℹ️  No workflows found"
    else
        # Parse workflow status with proper error handling
        STATUS=$(echo "$LATEST" | jq -r '.[0] | if .status == "completed" then (if .conclusion == "success" then "✅ \(.name)" elif .conclusion == "failure" then "❌ \(.name)" else "⚠️  \(.name) (\(.conclusion))" end) else "🔄 \(.name) (\(.status))" end' 2>/dev/null)
        
        if [ -n "$STATUS" ] && [ "$STATUS" != "null" ]; then
            echo "$STATUS"
        else
            echo "⚠️  Workflow status unknown"
        fi
    fi
else
    echo "ℹ️  No GitHub integration"
fi