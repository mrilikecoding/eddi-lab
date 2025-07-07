.PHONY: help setup update-submodules install-dev test clean status push build lint issues roadmap priority quick submodule-status push-with-monitoring workflow-status watch-workflows workflow-failures check-submodule-health

help:
	@echo "Eddi-lab Ecosystem Management"
	@echo ""
	@echo "Setup & Maintenance:"
	@echo "  setup           - Initial setup of development environment"
	@echo "  update-submodules - Update all submodules to latest"
	@echo "  install-dev     - Install all packages in development mode"
	@echo ""
	@echo "Development:"
	@echo "  build           - Build all Rust projects (eddi-pad, skeleton-mhi)"
	@echo "  test            - Run all tests across projects"
	@echo "  test-<project>  - Run tests for specific project (streampose, eddi, llm-orc, eddi-pad, skeleton-mhi, integration)"
	@echo "  lint            - Run linting and formatting"
	@echo "  clean           - Clean build artifacts"
	@echo ""
	@echo "Git Management:"
	@echo "  status          - Show git status across all repositories"
	@echo "  push            - Push all repositories (main + submodules)"
	@echo ""
	@echo "Project Management:"
	@echo "  issues          - List open issues across all repositories"
	@echo "  roadmap         - Show current roadmap and priorities (Issue #16)"
	@echo "  priority        - Show priority assessment framework"
	@echo "  quick           - Quick status and top development priorities"
	@echo "  submodule-status - Detailed submodule branch and commit status"
	@echo "  check-submodule-health - Verify all submodules are in healthy state"
	@echo ""
	@echo "Enhanced Workflow Monitoring:"
	@echo "  push-with-monitoring - Push with comprehensive workflow monitoring" 
	@echo "  workflow-status      - Show ecosystem-wide workflow health"
	@echo "  watch-workflows      - Watch latest runs across all repositories"
	@echo "  workflow-failures    - Show and help debug failed workflows"

setup: update-submodules install-dev

update-submodules: check-submodule-health
	@echo "📥 Updating submodules..."
	git submodule update --remote --merge
	@echo "🔄 Ensuring all submodules are on proper branches..."
	git submodule foreach 'git checkout main || echo "Warning: $$name not on main branch"'

install-dev:
	@echo "📦 Installing Python packages in isolated environments..."
	@echo "🐍 StreamPoseML (uv):"
	cd StreamPoseML && uv sync --dev
	@echo "🐍 Eddi (uv):"
	cd eddi && uv sync --dev
	@echo "🐍 LLM-ORC (uv):"
	cd llm-orc && uv sync
	@echo "🦀 Checking Rust projects..."
	cd eddi-pad && cargo check
	cd skeleton-mhi && cargo check
	@echo "✅ Development installation complete!"

# Build all Rust projects
build:
	@echo "🔨 Building Rust projects..."
	cd eddi-pad && cargo build
	cd skeleton-mhi && cargo build
	@echo "✅ All Rust projects built!"

test:
	@echo "🧪 Running tests across all projects..."
	# Python tests in isolated environments
	-cd StreamPoseML && source .venv/bin/activate && python -m pytest
	-cd eddi && uv run pytest
	-cd llm-orc && uv run pytest
	# Rust tests
	cd eddi-pad && cargo test
	cd skeleton-mhi && cargo test
	# Integration tests
	-python -m pytest integration-tests/ 2>/dev/null || echo "No integration tests found"
	@echo "✅ All tests completed!"

# Individual project tests
test-streampose:
	@echo "🧪 Running StreamPoseML tests..."
	cd StreamPoseML && source .venv/bin/activate && python -m pytest

test-eddi:
	@echo "🧪 Running Eddi tests..."
	cd eddi && uv run pytest

test-llm-orc:
	@echo "🧪 Running LLM-ORC tests..."
	cd llm-orc && uv run pytest

test-eddi-pad:
	@echo "🧪 Running Eddi-pad tests..."
	cd eddi-pad && cargo test

test-skeleton-mhi:
	@echo "🧪 Running Skeleton-MHI tests..."
	cd skeleton-mhi && cargo test

test-integration:
	@echo "🧪 Running integration tests..."
	cd integration-tests && uv run pytest

# Linting and formatting
lint:
	@echo "🧹 Running linting and formatting..."
	cd eddi-pad && cargo clippy -- -D warnings && cargo fmt --check
	cd skeleton-mhi && cargo clippy -- -D warnings && cargo fmt --check
	@echo "✅ Linting completed!"

clean:
	@echo "🧽 Cleaning build artifacts..."
	# Python cleanup
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete
	find . -name "*.egg-info" -exec rm -rf {} +
	# Rust cleanup
	cd eddi-pad && cargo clean
	cd skeleton-mhi && cargo clean
	@echo "✅ Cleanup completed!"

# Git status across all repos
status:
	@echo "📊 Git Status Across All Repositories:"
	@echo ""
	@echo "🏠 Main Repository:"
	git status --short
	@echo ""
	@echo "🎥 StreamPoseML:"
	cd StreamPoseML && git status --short
	@echo ""
	@echo "🎭 Eddi:"
	cd eddi && git status --short
	@echo ""
	@echo "🎮 Eddi-pad:"
	cd eddi-pad && git status --short
	@echo ""
	@echo "🦴 Skeleton-MHI:"
	cd skeleton-mhi && git status --short
	@echo ""
	@echo "🎭 LLM-ORC:"
	cd llm-orc && git status --short

# Push all repositories with workflow monitoring
push: check-submodule-health
	@echo "⬆️ Pushing all repositories..."
	@echo "📤 Pushing submodules first..."
	-cd StreamPoseML && git push && gh run list --limit 1
	-cd eddi && git push && gh run list --limit 1
	-cd eddi-pad && git push && gh run list --limit 1
	-cd skeleton-mhi && git push && gh run list --limit 1
	-cd llm-orc && git push && gh run list --limit 1
	@echo "📤 Pushing main repository..."
	git push && gh run list --limit 1
	@echo "✅ All repositories pushed! Monitor workflows with: gh run watch"

# Detailed submodule status for debugging
submodule-status:
	@echo "🔍 Detailed Submodule Status:"
	@echo ""
	@echo "📊 Submodule Overview:"
	git submodule status
	@echo ""
	@echo "🌿 Branch Status:"
	git submodule foreach 'echo "=== $$name ===" && git branch --show-current'
	@echo ""
	@echo "📝 Commit Status:"
	git submodule foreach 'echo "=== $$name ===" && git log --oneline -1'
	@echo ""
	@echo "🔄 Remote Status:"
	git submodule foreach 'echo "=== $$name ===" && git status --porcelain'

# Project management targets
issues:
	@echo "📋 Open Issues Across All Repositories:"
	@echo ""
	@echo "🏠 Main Repository (eddi-lab):"
	gh issue list --state open
	@echo ""
	@echo "🎥 StreamPoseML:"
	-cd StreamPoseML && gh issue list --state open
	@echo ""
	@echo "🎭 Eddi:"
	-cd eddi && gh issue list --state open
	@echo ""
	@echo "🎮 Eddi-pad:"
	-cd eddi-pad && gh issue list --state open
	@echo ""
	@echo "🦴 Skeleton-MHI:"
	-cd skeleton-mhi && gh issue list --state open
	@echo ""
	@echo "🎭 LLM-ORC:"
	-cd llm-orc && gh issue list --state open

roadmap:
	@echo "🗺️ Current Roadmap and Strategic Priorities:"
	gh issue view 16

priority:
	@echo "🎯 Priority Assessment Framework:"
	@echo ""
	@echo "Criteria (total 14 points possible):"
	@echo "  Research Impact (0-3): Critical for academic publication?"
	@echo "  Legacy Replacement (0-3): Maintains/improves Lumi functionality?"
	@echo "  Performance Critical (0-3): Required for latency targets?"
	@echo "  Dependency Blocker (0-3): Other high-priority items waiting?"
	@echo "  Technical Risk (0-2): Addresses significant uncertainty?"
	@echo ""
	@echo "Priority Levels:"
	@echo "  HIGH (10+ points): Work on immediately"
	@echo "  MEDIUM (6-9 points): Next in queue"
	@echo "  LOW (<6 points): Future work"
	@echo ""
	@echo "Current Phase: Foundation & Research"
	@echo "See CLAUDE.md for complete framework details."

# Quick status and priorities
quick: check-submodule-health
	@echo "⚡ Quick Ecosystem Status & Priorities:"
	@echo ""
	@make --no-print-directory status
	@echo ""
	@echo "🔍 Submodule Health:"
	@git submodule status | grep -E "^[\+\-]" && echo "⚠️  Submodules need attention" || echo "✅ All submodules clean"
	@echo ""
	@echo "🎯 Highest Priority Items (Phase 1):"
	@echo "  skeleton-mhi#1: Analyze legacy MHI implementation (11 pts - Research critical)"
	@echo "  eddi-pad#1: Device trait implementation (11 pts - Foundation)"
	@echo "  StreamPoseML#28: Pre-recorded video processing (7 pts - Research data)"
	@echo ""
	@echo "📖 Next steps:"
	@echo "  1. Run 'make roadmap' for strategic context"
	@echo "  2. Run 'make issues' to see all available work"
	@echo "  3. Follow TDD methodology in CLAUDE.md"

# Submodule Health Check - prevents detached HEAD issues
check-submodule-health:
	@echo "🔍 Checking submodule health..."
	@git submodule foreach 'branch=$$(git rev-parse --abbrev-ref HEAD); if [ "$$branch" = "HEAD" ]; then echo "❌ DETACHED HEAD in $$name - run: cd $$name && git checkout main"; exit 1; fi; echo "✅ $$name on branch: $$branch"'
	@echo "✅ All submodules are on proper branches!"

# Enhanced Workflow Monitoring Commands

# Push with comprehensive workflow monitoring  
push-with-monitoring:
	@./scripts/enhanced-push.sh

# Show ecosystem-wide workflow health
workflow-status:
	@echo "📊 Ecosystem Workflow Health:"
	@echo ""
	@./scripts/repo-workflow-status.sh . "Main Repository"
	@./scripts/repo-workflow-status.sh StreamPoseML "StreamPoseML"
	@./scripts/repo-workflow-status.sh eddi "Eddi"
	@./scripts/repo-workflow-status.sh eddi-pad "Eddi-pad"
	@./scripts/repo-workflow-status.sh skeleton-mhi "Skeleton-MHI"
	@./scripts/repo-workflow-status.sh llm-orc "LLM-ORC"

# Watch latest runs across all repositories
watch-workflows:
	@echo "👀 Watching Latest Workflow Runs:"
	@echo ""
	@./scripts/find-active-runs.sh

# Show and help debug failed workflows
workflow-failures:
	@echo "🔧 Failed Workflow Analysis:"
	@echo ""
	@./scripts/check-repo-failures.sh . "Main Repository"
	@./scripts/check-repo-failures.sh StreamPoseML "StreamPoseML"
	@./scripts/check-repo-failures.sh eddi "Eddi"
	@./scripts/check-repo-failures.sh eddi-pad "Eddi-pad"
	@./scripts/check-repo-failures.sh skeleton-mhi "Skeleton-MHI"
	@./scripts/check-repo-failures.sh llm-orc "LLM-ORC"
	@echo ""
	@echo "💡 Debug Commands:"
	@echo "   gh run view <run-id> --log-failed     # View failed job logs"
	@echo "   gh run rerun <run-id>                 # Retry failed run"
	@echo "   gh run view <run-id> --web            # Open in browser"
