#!/bin/bash
set -e

# Find active workflow runs across all repositories
# Usage: ./find-active-runs.sh

echo "🔍 Finding active/recent runs..."

REPOS=("." "StreamPoseML" "eddi" "eddi-pad" "skeleton-mhi" "llm-orc")
REPO_NAMES=("main repo" "StreamPoseML" "eddi" "eddi-pad" "skeleton-mhi" "llm-orc")
ACTIVE_RUNS=""

# Check each repository for active runs
for i in "${!REPOS[@]}"; do
    REPO="${REPOS[$i]}"
    REPO_NAME="${REPO_NAMES[$i]}"
    
    cd "$REPO"
    
    # Look for in-progress runs
    RUNS=$(gh run list --limit 3 --status in_progress --json databaseId,name,status 2>/dev/null | jq -r ".[] | \"\(.databaseId) \(.name) ($REPO_NAME)\"" 2>/dev/null || true)
    
    if [ -n "$RUNS" ]; then
        ACTIVE_RUNS="$ACTIVE_RUNS$RUNS"$'\n'
    fi
    
    # Return to root for next iteration
    if [ "$REPO" != "." ]; then
        cd ..
    fi
done

# Report results
if [ -n "$ACTIVE_RUNS" ] && [ "$ACTIVE_RUNS" != $'\n' ]; then
    echo "🔄 Active runs found. Use 'gh run watch <run-id>' to monitor:"
    echo "$ACTIVE_RUNS" | head -3 | sed '/^$/d'
else
    echo "ℹ️  No active runs found."
    echo "  💡 Use 'make workflow-status' to see ecosystem health"
fi