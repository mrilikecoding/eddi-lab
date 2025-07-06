.PHONY: help setup update-submodules install-dev test clean status push build lint issues roadmap priority quick submodule-status

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

setup: update-submodules install-dev

update-submodules:
	@echo "⚠️  Checking for detached HEAD states..."
	git submodule foreach 'git branch --show-current | grep -q "^[^(]" || (echo "ERROR: $$name in detached HEAD" && exit 1)'
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
push:
	@echo "⬆️ Pushing all repositories..."
	@echo "🔍 Checking for detached HEAD states..."
	git submodule foreach 'git branch --show-current | grep -q "^[^(]" || (echo "ERROR: $$name in detached HEAD" && exit 1)'
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
quick:
	@echo "⚡ Quick Ecosystem Status & Priorities:"
	@echo ""
	@make --no-print-directory status
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
