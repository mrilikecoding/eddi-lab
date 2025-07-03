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

## Development Workflow

### Running Tests
```bash
# Run all tests across projects
make test

# Run tests for specific projects
make test-streampose    # StreamPoseML tests
make test-eddi         # Eddi tests  
make test-llm-orc      # LLM Orchestra tests
make test-eddi-pad     # Eddi-pad tests
make test-skeleton-mhi # Skeleton-MHI tests
make test-integration  # Cross-repo integration tests
```

### Project Management
```bash
make quick    # Quick status overview + top priorities
make status   # Git status across all repositories  
make issues   # List open issues across all repositories
make roadmap  # Show current strategic roadmap
```

### Other Commands
```bash
make build    # Build all Rust projects
make lint     # Run linting and formatting
make clean    # Clean build artifacts
make push     # Push all repositories
```

## Architecture

This ecosystem follows TDD methodology and separates concerns across specialized components:

- **Real-time Performance**: Sub-millisecond device latency, <100ms end-to-end pipeline
- **Spatial Intelligence**: Proven spatial zone models from legacy Lumi system
- **Research Foundation**: Academic publication pipeline for Skeleton-MHI approach
- **Agent-Driven Development**: Multi-agent system for code review and development assistance

See [CLAUDE.md](./CLAUDE.md) for detailed development methodology and cross-repo coordination guidelines.
