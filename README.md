# eddi-lab Development Workspace

This meta-repo holds the dev environment for integrated work on packages related to Eddi - an interactive installation system that responds to human movement with spatial intelligence.

## Components

### Core System
- **[eddi](https://github.com/mrilikecoding/eddi)**: Spatial intelligence and AI Director for environmental response (Python)
- **[eddi-pad](https://github.com/mrilikecoding/eddi-pad)**: High-performance device control and simulation environment (Rust)

### Data Pipeline  
- **[StreamPoseML](https://github.com/mrilikecoding/StreamPoseML)**: Real-time pose extraction and feature engineering (Python/React)
- **[skeleton-mhi](https://github.com/mrilikecoding/skeleton-mhi)**: Novel gesture segmentation using keypoint-based Motion History Images (Rust)

### Agent System
- **[llm-orc](https://github.com/mrilikecoding/llm-orc)**: Multi-agent LLM communication system with flexible role definitions (Python)

## Data Flow Pipeline
```
Input → StreamPoseML → Skeleton-MHI → Eddi → Eddi-pad → Devices
Devices  (pose data)   (gesture      (spatial (device   (output)
                       segments)     response) control)
```

## Development Setup

1. Clone this repository with submodules:
   ```bash
   git clone --recurse-submodules https://github.com/mrilikecoding/eddi-lab.git
   cd eddi-lab
   ```

2. Set up development environment:
   ```bash
   make setup
   ```

3. Verify submodule health:
   ```bash
   make submodule-status
   ```

### Robust Submodule Workflow

This ecosystem has been designed to prevent common submodule issues:
- **Detached HEAD detection** prevents accidental commits in wrong state
- **Safe update operations** with automatic branch verification
- **Enhanced push monitoring** with GitHub Actions integration
- **Cross-repo failure tracking** for quick debugging

## Development Workflow

### Development Environment

This ecosystem uses modern tooling for optimal developer experience:
- **Python Projects**: `uv` for fast dependency management (eddi, llm-orc, StreamPoseML)
- **Rust Projects**: `cargo` for building and testing (eddi-pad, skeleton-mhi)

### Running Tests
```bash
# Run all tests across projects
make test

# Run tests for specific projects
make test-streampose    # StreamPoseML tests (uv)
make test-eddi         # Eddi tests (uv)
make test-llm-orc      # LLM Orchestra tests (uv)
make test-eddi-pad     # Eddi-pad tests (cargo)
make test-skeleton-mhi # Skeleton-MHI tests (cargo)
make test-integration  # Cross-repo integration tests
```

### Working on Individual Projects
```bash
# For uv-enabled projects (eddi, llm-orc, StreamPoseML)
cd eddi && make test          # or: uv run pytest
cd llm-orc && make test       # or: uv run pytest
cd StreamPoseML && uv run pytest

# For Rust projects
cd eddi-pad && cargo test
cd skeleton-mhi && cargo test
```

### Project Management
```bash
make quick    # Quick status overview + top priorities
make status   # Git status across all repositories  
make issues   # List open issues across all repositories
make roadmap  # Show current strategic roadmap
```

### Enhanced Workflow Monitoring
```bash
# Enhanced push with comprehensive monitoring
make push-with-monitoring

# Ecosystem health monitoring
make workflow-status      # View GitHub Actions status across all repos
make watch-workflows      # Find and monitor active workflow runs
make workflow-failures    # Analyze recent failures with debug commands

# Traditional commands
make build    # Build all Rust projects
make lint     # Run linting and formatting
make clean    # Clean build artifacts
make push     # Push all repositories (basic monitoring)
```

### Submodule Management
```bash
make submodule-status     # Detailed submodule branch and commit status
make update-submodules    # Update all submodules with detached HEAD protection
```

## Architecture

This ecosystem follows TDD methodology and separates concerns across specialized components:

- **Real-time Performance**: Sub-millisecond device latency, <100ms end-to-end pipeline
- **Spatial Intelligence**: Proven spatial zone models from legacy Lumi system
- **Research Foundation**: Academic publication pipeline for Skeleton-MHI approach
- **Agent-Driven Development**: Multi-agent system for code review and development assistance

See [CLAUDE.md](./CLAUDE.md) for detailed development methodology and cross-repo coordination guidelines.
