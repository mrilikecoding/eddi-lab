#!/bin/bash
set -e

# Enhanced push with comprehensive workflow monitoring
# Usage: ./enhanced-push.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "⬆️ Enhanced Push with Workflow Monitoring..."
echo "🔍 Checking for detached HEAD states..."

# Check for detached HEAD states
git submodule foreach 'git branch --show-current | grep -q "^[^(]" || (echo "ERROR: $name in detached HEAD" && exit 1)'

echo ""
echo "📤 Pushing submodules and monitoring workflows..."

# Push each submodule
REPOS=("StreamPoseML" "eddi" "eddi-pad" "skeleton-mhi" "llm-orc")
for repo in "${REPOS[@]}"; do
    "$SCRIPT_DIR/push-submodule.sh" "$repo"
done

echo ""
echo "📤 Pushing main repository..."

# Push main repo
echo "  🏠 Main Repository:"
if git push 2>/dev/null; then
    echo "    ✅ Push successful"
    
    # Check for workflow status
    if LATEST=$(gh run list --limit 1 --json status,conclusion,name 2>/dev/null); then
        if [ "$LATEST" = "[]" ]; then
            echo "    ℹ️  No workflows configured"
        else
            echo "$LATEST" | jq -r '.[0] // empty | "    🔄 Latest: \(.name) (\(.status))"' 2>/dev/null || echo "    ℹ️  No workflows configured"
        fi
    else
        echo "    ℹ️  No workflows configured"
    fi
else
    echo "    ℹ️  No changes to push"
fi

echo ""
echo "📊 Ecosystem Workflow Summary:"

# Show workflow status for all repos
REPOS=("." "StreamPoseML" "eddi" "eddi-pad" "skeleton-mhi" "llm-orc")
REPO_NAMES=("Main Repository" "StreamPoseML" "Eddi" "Eddi-pad" "Skeleton-MHI" "LLM-ORC")

for i in "${!REPOS[@]}"; do
    "$SCRIPT_DIR/repo-workflow-status.sh" "${REPOS[$i]}" "${REPO_NAMES[$i]}"
done

echo ""
echo "💡 Use 'make watch-workflows' to monitor active runs"
echo "💡 Use 'make workflow-failures' to debug any failures"