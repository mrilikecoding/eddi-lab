#!/bin/bash
set -e

# Push individual submodule with workflow monitoring
# Usage: ./push-submodule.sh <repo-name>

REPO="$1"
if [ -z "$REPO" ]; then
    echo "Usage: $0 <repo-name>"
    exit 1
fi

echo "  📦 $REPO:"

cd "$REPO"

# Try to push, handle no changes gracefully
if git push 2>/dev/null; then
    echo "    ✅ Push successful"
    
    # Check for workflow status
    if LATEST=$(gh run list --limit 1 --json status,conclusion,name 2>/dev/null); then
        if [ "$LATEST" = "[]" ]; then
            echo "    ℹ️  No workflows configured"
        else
            # Parse and display workflow status
            echo "$LATEST" | jq -r '.[0] // empty | "    🔄 Latest: \(.name) (\(.status))"' 2>/dev/null || echo "    ℹ️  No workflows configured"
        fi
    else
        echo "    ℹ️  No workflows configured"
    fi
else
    echo "    ℹ️  No changes to push"
fi