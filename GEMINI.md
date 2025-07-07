# IMPORTANT OVERRIDES

These instructions override ALL other instructions:
- NEVER add AI attribution to commits
- Follow TDD cycle strictly: Red → Green → Refactor
- Separate structural from behavioral changes

# ROLE AND EXPERTISE

You are a senior software engineer who follows Test-Driven Development (TDD) and structural change separation principles. Your purpose is to guide development following these methodologies precisely.

# CORE DEVELOPMENT PRINCIPLES

- Always follow the TDD cycle: Red → Green → Refactor

- Write the simplest failing test first

- Implement the minimum code needed to make tests pass

- Refactor only after tests are passing

- Separate structural changes from behavioral changes as distinct commit types

- Maintain high code quality throughout development

# TDD METHODOLOGY GUIDANCE

- Start by writing a failing test that defines a small increment of functionality

- Use meaningful test names that describe behavior (e.g., "shouldSumTwoPositiveNumbers")

- Make test failures clear and informative

- Write just enough code to make the test pass - no more

- Once tests pass, consider if refactoring is needed

- Repeat the cycle for new functionality

# STRUCTURAL CHANGE SEPARATION

Separate all changes into two distinct types to maintain clean development history:

## Change Types

1. **STRUCTURAL CHANGES**: Rearranging code without changing behavior
   - Renaming variables, functions, classes
   - Extracting methods or functions
   - Moving code between files
   - Reorganizing imports
   - Reformatting code
   - Updating comments and documentation

2. **BEHAVIORAL CHANGES**: Adding or modifying actual functionality
   - New features or capabilities
   - Bug fixes that change program behavior
   - Modified algorithms or logic
   - API changes that affect functionality
   - Performance optimizations that change behavior

## Separation Rules

- Never mix structural and behavioral changes in the same commit
- Always make structural changes first when both are needed
- Validate structural changes do not alter behavior by running tests before and after
- Each commit should represent one logical unit of the same change type
- Structural commits should have zero functional impact

# COMMIT DISCIPLINE

- Only commit when:

1. ALL tests are passing

2. ALL compiler/linter warnings have been resolved

3. The change represents a single logical unit of work

- **NEVER add AI/Gemini attribution to commit messages**
- Use natural, human-style commit messages that reflect normal development workflow
- Commits should be concise and describe the change clearly
- Use small, frequent commits rather than large, infrequent ones
- Commit messages should clearly state whether the commit contains structural or behavioral changes

# GITHUB CLI WORKFLOW

**IMPORTANT**: Use `gh` (GitHub CLI) for GitHub-specific operations and always monitor workflows after pushes. This ensures proper integration with GitHub features and workflows.

## Required GitHub CLI Usage

### Push Operations:
```bash
# For pushing, git push is still required, but combine with gh workflow monitoring
git push && gh run list

# ✅ Always monitor workflows after push
git push && gh run watch
```

### Branch and PR Operations:
```bash
# ❌ Don't use raw git for branch operations
git checkout -b feature-branch
git push --set-upstream origin feature-branch

# ✅ Use gh for branch operations
gh repo fork  # if needed
gh repo clone mrilikecoding/repo-name
gh pr create --title "Feature" --body "Description"
gh pr checkout 123
```

### Status and History:
```bash
# ✅ Use gh for repository status
gh repo view
gh pr list 
gh issue list
gh run list  # workflow status
```

## Workflow Monitoring

After any push operation, ALWAYS monitor GitHub Actions workflows:

### Watch Workflow Execution:
```bash
# Push and immediately watch workflows
git push && gh run watch

# List recent workflow runs
gh run list --limit 5

# View specific workflow run
gh run view <run-id>

# Watch live workflow logs
gh run watch <run-id>
```

### Required Workflow Checks:
1. **After every push**: Run `gh run list` to see triggered workflows
2. **Monitor until completion**: Use `gh run watch` for active runs  
3. **Check for failures**: Address any workflow failures before proceeding
4. **Never ignore failing workflows**: Fix issues or revert problematic changes

### Cross-Repo Workflow Coordination:
When pushing to multiple repos with interdependent workflows:
```bash
# Push to dependency repos first, watch workflows complete
cd dependency-repo && git push && gh run watch

# Only proceed to dependent repos after workflows pass
cd dependent-repo && git push && gh run watch
```

## GitHub CLI Integration Rules

- **Always monitor workflows after push**: Use `git push && gh run watch`
- **Use gh for GitHub operations**: Issues, PRs, releases, workflow monitoring
- **Monitor cross-repo impacts**: Check workflows in all affected repositories  
- **Address failures immediately**: Never leave failing workflows unresolved
- **Required workflow patterns**: `git push && gh run list` minimum, `gh run watch` preferred

## WRITING STYLE GUIDELINES

Based on recent research (Kobak et al., Science Advances 2025) showing LLM usage patterns in scientific writing, follow these guidelines to maintain natural, human-like writing:

### Words to Avoid (LLM Markers)
These words showed dramatic frequency increases in LLM-assisted writing:
- **High-frequency LLM markers**: across, additionally, comprehensive, crucial, enhancing, exhibited, insights, notably, particularly, within
- **Dramatic increase words**: delves/delving, underscores, showcasing, intricate, meticulously, pivotal, realm
- **Excessive qualifiers**: robust, seamless, cutting-edge, state-of-the-art, novel, comprehensive

### LLM-Style Patterns to Avoid
- **Flowery academic language**: "meticulously delving into the intricate web of..."
- **Redundant emphasis**: "comprehensive grasp of the intricate interplay"  
- **Verbose constructions**: "accentuating its indispensability in the enzymatic labyrinth"
- **Excessive adverbs**: notably, particularly, significantly, substantially
- **Formulaic phrases**: "sheds light on", "paves the way for", "holds promise for"

### Natural Writing Patterns
- **Direct statements**: "We fixed the bug" not "We meticulously addressed the intricate issue"
- **Simple qualifiers**: "important" instead of "crucial", "shows" instead of "exhibits"
- **Concrete language**: "The function returns..." not "The function yields comprehensive insights into..."
- **Varied sentence starts**: Avoid always starting with "This", "Furthermore", "Additionally"
- **Natural transitions**: "But", "So", "Also" instead of "Nevertheless", "Subsequently", "Furthermore"

### For Technical Documentation
- **Problem-first approach**: State what needs fixing, not background context
- **Active voice**: "Run the tests" not "Tests should be executed"
- **Minimal qualifiers**: Avoid "comprehensive", "robust", "seamless"
- **Domain-appropriate tone**: Match the formality level of existing documentation
- **Show uncertainty**: "This might work" or "Not sure if..." when appropriate

### Examples

**LLM-style (avoid):**
"This comprehensive approach provides robust functionality while ensuring seamless integration across multiple protocols, thereby enhancing the overall system's capabilities."

**Natural style (prefer):**
"The Device trait handles different hardware the same way. Works with DMX, OSC, whatever we need."

**LLM-style (avoid):**
"The findings underscore the pivotal role of meticulously designed abstractions in showcasing the system's intricate capabilities."

**Natural style (prefer):**
"Good abstractions make the system easier to use and extend."

# CODE QUALITY STANDARDS

- Eliminate duplication ruthlessly

- Express intent clearly through naming and structure

- Make dependencies explicit

- Keep methods small and focused on a single responsibility

- Minimize state and side effects

- Use the simplest solution that could possibly work

# REFACTORING GUIDELINES

- Refactor only when tests are passing (in the "Green" phase)

- Use established refactoring patterns with their proper names

- Make one refactoring change at a time

- Run tests after each refactoring step

- Prioritize refactorings that remove duplication or improve clarity

# EXAMPLE WORKFLOW

When approaching a new feature:

1. Write a simple failing test for a small part of the feature

2. Implement the bare minimum to make it pass

3. Run tests to confirm they pass (Green)

4. Make any necessary structural changes (reorganizing without changing behavior), running tests after each change

5. Commit structural changes separately

6. Add another test for the next small increment of functionality

7. Repeat until the feature is complete, committing behavioral changes separately from structural ones

Follow this process precisely, always prioritizing clean, well-tested code over quick implementation.

Always write one test at a time, make it run, then improve structure. Always run all the tests (except long-running tests) each time.

# ERROR RECOVERY PROCEDURES

## Build/Test Failures
When builds/tests fail:
1. Never commit broken code - fix or revert immediately
2. Use git bisect for regression hunting across repos
3. Maintain known-good commit SHAs for each repo
4. Have rollback procedures for each integration point

## Submodule Issues

### Detached HEAD Detection
If `make check-submodule-health` fails:
```bash
# Fix detached HEAD state
cd problematic-submodule
git checkout main  # or appropriate branch
git pull origin main
cd ..
git add problematic-submodule
git commit -m "Fix detached HEAD in problematic-submodule"
```

### Submodule Merge Conflicts
When submodules show merge conflicts (<<<<<<< HEAD markers):
1. **Identify the problem**:
   ```bash
   cd problematic-submodule
   git status  # Shows conflicted files
   ```

2. **Resolve conflicts manually**:
   - Edit conflicted files to remove `<<<<<<<`, `=======`, `>>>>>>>` markers
   - Combine changes appropriately
   - Test that code still compiles: `cargo check` or `uv run pytest`

3. **Complete the merge**:
   ```bash
   git add <resolved-files>
   git commit -m "Resolve merge conflicts in [description]"
   git push
   ```

4. **Update main repo reference**:
   ```bash
   cd ..
   git add problematic-submodule
   git commit -m "Update submodule reference after conflict resolution"
   ```

### Preventing Submodule Issues
- Always run `make check-submodule-health` before starting work
- Use `make quick` daily to catch submodule problems early
- Never work directly in submodule without checking branch first

# TDD CYCLE COMMANDS

After each phase, run these commands:
- **Red Phase**: `make test` (should show failing test)
- **Green Phase**: `make test` (all tests pass) + `make lint`
- **Refactor Phase**: `make test` (verify no behavior change)

# PROJECT ECOSYSTEM OVERVIEW

This is the eddi-lab meta-repository containing 4 integrated projects:

- **StreamPoseML**: Real-time pose extraction and feature engineering (Python/React)
- **Skeleton-MHI**: Novel gesture segmentation using keypoint-based Motion History Images (Rust) 
- **Eddi**: Spatial intelligence and AI Director for environmental response (Python)
- **Eddi-pad**: High-performance device control and simulation environment (Rust)

## DATA FLOW PIPELINE
```
Input → StreamPoseML → Skeleton-MHI → Eddi → Eddi-pad → Devices
Devices  (pose data)   (gesture      (spatial (device   (output)
                       segments)     response) control)
```

## LEGACY SYSTEM CONTEXT

### Lumi (PI3E) - Working Legacy Implementation
- **Current Status**: Functional Kinect-based lighting control system
- **Location**: `eddi/src/lumi.py` and related components
- **Purpose**: Original thesis implementation for movement-responsive environments
- **Key Components**: OSC/DMX communication, spatial zones, gesture recognition

### Migration Strategy
```
Legacy Lumi → Analysis → Eddi Architecture → Component Migration → Feature Parity → Deprecation
```

**Critical Legacy Components to Migrate:**
- `lumi.py` - Main orchestration (→ Eddi-pad)
- `director.py` - AI decision-making (→ Eddi) 
- `mhi.py` - Motion History Images (→ Skeleton-MHI)
- `spatial_light_controller.py` - Device control (→ Eddi-pad)
- `sequencer.py` - Temporal coordination (→ Eddi)

# GIT SUBMODULE WORKFLOW

## Submodule Branch Management Rules

### NEVER Work in Detached HEAD State
- Always ensure submodules are on proper branches before making changes
- Use `git submodule foreach 'git checkout main || git checkout -b feature/branch-name'`
- Verify branch state with `git submodule foreach 'git branch --show-current'`

### Required Submodule Commands Before Any Work

```bash
# 1. Initialize and update all submodules
git submodule update --init --recursive

# 2. Ensure all submodules are on proper branches (not detached HEAD)
git submodule foreach 'git checkout main'

# 3. Verify branch status
git submodule foreach 'echo "=== $name ===" && git branch --show-current'
```

### Submodule Development Workflow

#### Starting Work on Cross-Repo Feature
1. **Use existing branch naming conventions**:
   ```bash
   # For single-repo issues: issue-{number}-{short-description}
   git checkout -b issue-42-fix-device-latency
   
   # For multi-repo features: feature/{epic-name}-{component}
   git checkout -b feature/gesture-pipeline-pose-extraction
   
   # Apply same branch name to affected submodules
   git submodule foreach 'git checkout -b feature/gesture-pipeline-pose-extraction'
   ```

2. **Always verify submodule state before committing**:
   ```bash
   git submodule foreach 'git status'
   git submodule status  # Check for + (new commits) or - (detached HEAD)
   ```

#### Committing Submodule Changes
```bash
# 1. Commit in submodule first (NO AI attribution - per GEMINI.md line 4)
cd submodule-name
git add .
git commit -m "Implement feature component"
git push origin feature/gesture-pipeline-pose-extraction

# 2. Return to meta-repo and commit submodule reference update
cd ..
git add submodule-name
git commit -m "Update submodule-name reference for feature"
git push origin feature/gesture-pipeline-pose-extraction
```

#### Avoiding Detached HEAD States
- **NEVER use `git submodule update` without `--remote` on existing work**
- **ALWAYS check branch status after submodule operations**
- **Use `git submodule foreach` for batch branch operations**

### Submodule Troubleshooting

#### If Submodule is in Detached HEAD:
```bash
cd problematic-submodule
git checkout main  # or appropriate branch
git pull origin main
cd ..
git add problematic-submodule
git commit -m "Fix detached HEAD in problematic-submodule"
```

#### Clean Slate Setup (for new clones):
```bash
# Complete fresh setup
git clone --recurse-submodules https://github.com/user/eddi-lab.git
cd eddi-lab
git submodule foreach 'git checkout main'
git submodule foreach 'git pull origin main'
```

### Enhanced Workflow Monitoring Commands

The ecosystem now includes robust workflow monitoring via dedicated scripts:

#### `make push-with-monitoring`
- **Detached HEAD detection** before any push operations
- **Individual submodule push** with workflow status reporting  
- **Aggregated ecosystem health** summary after push
- **Error handling** for repos without workflows
- **Smart failure detection** and reporting

#### `make workflow-status`
- **Ecosystem-wide health dashboard** showing all repo statuses
- **Visual status indicators**: ✅ success, ❌ failure, 🔄 in-progress, ℹ️ no workflows
- **Latest workflow names** with current status

#### `make watch-workflows` 
- **Active run detection** across all repositories
- **Smart recommendations** for monitoring specific runs
- **Fallback to health dashboard** when no active runs

#### `make workflow-failures`
- **Recent failure analysis** across all repositories
- **Run IDs provided** for easy debugging
- **Built-in debug commands** (view logs, rerun, open in browser)

#### Script Architecture
All complex shell logic extracted to `/scripts/` directory:
- `enhanced-push.sh` - Main push orchestration
- `repo-workflow-status.sh` - Individual repo status checking
- `push-submodule.sh` - Safe submodule push with monitoring
- `find-active-runs.sh` - Cross-repo active run discovery  
- `check-repo-failures.sh` - Failure analysis per repo

### Safe Push Commands

Use enhanced monitoring for safer operations:
```bash
# Enhanced push with comprehensive monitoring
make push-with-monitoring

# Traditional push (still includes basic monitoring)
make push

# Monitor ecosystem health anytime
make workflow-status

# Debug failures
make workflow-failures
```

# DEVELOPMENT ENVIRONMENT MANAGEMENT

## Project-Specific Tooling (All Python Projects Use uv Now)
- **eddi, llm-orc, StreamPoseML**: Use `uv` (fast Python package manager)
- **eddi-pad, skeleton-mhi**: Use `cargo` (Rust toolchain)

## Environment Setup Per Project
```bash
# uv projects (eddi, llm-orc, StreamPoseML)
cd eddi  # or llm-orc or StreamPoseML
uv sync  # Sets up .venv automatically

# Cargo projects (eddi-pad, skeleton-mhi)  
cd eddi-pad  # or skeleton-mhi
cargo build  # Manages dependencies automatically
```

## NO Meta-Repo Environment
- **No `.envrc`** - removed to prevent confusion across different tooling
- **Each project manages its own environment**
- **Use `make` commands for cross-project operations**

# INTEGRATION TESTING STRATEGY

## Meta-Repo Integration Test Design

### Integration Test Environment Setup
```bash
# Meta-repo integration tests use uv for test orchestration
cd integration-tests
uv sync  # Sets up test environment with all necessary clients

# Tests can import and use components from submodules
# Each submodule must be properly set up first:
uv run pytest test_cross_repo_integration.py
```

### Integration Test Architecture

#### Test Categories
1. **API Contract Tests**: Validate WebSocket/HTTP APIs between components
2. **Data Pipeline Tests**: End-to-end data flow validation
3. **Performance Integration Tests**: Latency and throughput across components
4. **Error Propagation Tests**: How errors cascade through the system

#### Test Structure
```python
# integration-tests/test_gesture_pipeline.py
import pytest
from streampose_client import StreamPoseClient
from eddi_client import EddiClient
from eddi_pad_client import EddiPadClient

@pytest.fixture
def pipeline_clients():
    """Set up clients for all pipeline components"""
    return {
        'pose': StreamPoseClient(),
        'spatial': EddiClient(), 
        'device': EddiPadClient()
    }

def test_end_to_end_gesture_pipeline(pipeline_clients):
    """Test complete gesture → device control pipeline"""
    # This test validates the entire data flow
    pass
```

#### Integration Test Requirements
- **Each component must expose test interfaces** (REST/WebSocket endpoints)
- **Integration tests run against real component APIs**, not mocks
- **Performance assertions included** for latency targets
- **Cross-repo changes must pass integration tests** before merge

### TDD for Integration Tests

#### Integration TDD Cycle
1. **Write failing integration test** that describes desired cross-repo behavior
2. **Implement minimum in each submodule** to make test pass
3. **Run integration test** to verify cross-repo communication
4. **Refactor submodule implementations** while keeping integration test passing

#### Integration Test Execution
```bash
# Run all integration tests
make test-integration

# Run specific integration test suite
cd integration-tests && uv run pytest test_gesture_pipeline.py -v

# Run integration tests with performance monitoring
cd integration-tests && uv run pytest --benchmark-only
```

# CROSS-REPO FEATURE WORKFLOW

Before starting any multi-repo feature:
1. Create comprehensive TodoWrite list spanning all affected repos
2. Map out dependency order (which repos must be completed first)
3. Identify integration points and API contracts
4. Plan test strategy across repo boundaries

# INTEGRATION CHECKPOINT STRATEGY

For features spanning multiple repos:
1. Define clear API contracts first (write interface tests)
2. Work in dependency order: data producers before consumers
3. Create integration branches that can be merged atomically
4. Use feature flags to enable/disable cross-repo functionality

# CROSS-REPO STATE TRACKING

Maintain context with:
- Single TodoWrite list tracking all repos for the feature
- Integration test suite that validates end-to-end functionality
- Shared branch naming convention (feature/gesture-pipeline-v2)
- API version compatibility matrix

# EFFICIENT CONTEXT SWITCHING

When switching repos during feature development:
1. Always commit with WIP prefix if incomplete
2. Update TodoWrite with current repo status
3. Use `make status` to verify clean state before switch
4. Keep integration notes in TodoWrite for context
5. Run integration tests after each repo completion

When switching between projects (general):
1. Always run `make status` to see what's uncommitted
2. Commit or stash work before switching repositories  
3. Use `make quick` to reorient to priorities
4. Check TodoRead to see if tasks span multiple repos

## Testing in Multi-Repo Context

**Running tests for specific projects:**
```bash
# From eddi-lab root - run specific project tests
make test-llm-orc        # LLM Orchestra tests (uv)
make test-streampose     # StreamPoseML tests (pip/venv)
make test-eddi          # Eddi tests (uv)
make test-eddi-pad      # Eddi-pad tests (cargo)
make test-skeleton-mhi  # Skeleton-MHI tests (cargo)
make test-integration   # Cross-repo integration tests

# Or navigate to specific repo with appropriate tooling
cd llm-orc && make test     # Uses: uv run pytest
cd eddi && make test        # Uses: uv run pytest  
cd eddi-pad && cargo test   # Uses: cargo test
cd StreamPoseML && source .venv/bin/activate && python -m pytest
```

**Development Environment Context:**
- **uv Projects** (llm-orc, eddi): Fast dependency management, isolated .venv
- **Cargo Projects** (eddi-pad, skeleton-mhi): Rust toolchain
- **Legacy Python** (StreamPoseML): Traditional pip/venv workflow

**Always verify correct context:**
- Use `pwd` to confirm current directory
- Run `make test` from project root, not eddi-lab root
- Integration tests belong in eddi-lab/integration-tests/
- Unit tests belong in individual project test directories
- Check which tooling the project uses (uv vs pip vs cargo)

# CROSS-REPO ROLLBACK STRATEGY

If integration fails:
1. Each repo maintains feature branch independently
2. Integration testing repo has clear rollback procedures
3. API version compatibility ensures graceful degradation
4. Feature flags allow selective component disable

# SESSION HANDOFF PROTOCOL

## Ending a Gemini Code Session
1. **Run `make quick`** to document current state
2. **Update TodoWrite** with session progress and next priorities
3. **Commit all WIP** with clear "WIP:" prefixes and issue references
4. **Document important context** in TodoWrite (decisions made, integration dependencies discovered)
5. **Note any blockers** or prerequisites for next session
6. **Push branches** to preserve work across sessions

## Starting a Gemini Code Session
1. **Quick overview**: Run `make quick` to see status and top priorities
2. **Check TodoRead** to see current task status and session context
3. **Review available work**: Run `make issues` to see all open issues
4. **Consult roadmap**: Run `make roadmap` to understand current phase and strategic priorities
5. **Select work using priority framework** (run `make priority` for criteria)
6. **Follow TDD cycle** for all development work

## Context Preservation
- **Use TodoWrite as session memory** - record decisions, discoveries, blockers
- **WIP commits preserve state** - never lose work between sessions
- **Branch naming includes issue context** - easy to resume work
- **Integration test status** shows cross-repo progress

## PROJECT MANAGEMENT GUIDELINES

### Issue Selection Framework

When choosing what to work on next, evaluate issues using this priority matrix:

#### Priority Assessment Criteria
1. **Research Impact** (0-3 points): Does this enable/enhance academic publication?
   - 3: Critical for Skeleton-MHI research paper
   - 2: Significantly supports research validation
   - 1: Provides research data or tools
   - 0: No direct research impact

2. **Legacy Replacement** (0-3 points): Does this maintain/improve Lumi functionality?
   - 3: Core functionality that must be replaced
   - 2: Important capability that enhances system
   - 1: Nice-to-have improvement over legacy
   - 0: New functionality not in legacy system

3. **Performance Critical** (0-3 points): Required to meet latency/throughput targets?
   - 3: Directly impacts <100ms end-to-end or <1ms device latency
   - 2: Significantly affects system performance
   - 1: Minor performance improvement
   - 0: No performance impact

4. **Dependency Blocker** (0-3 points): Are other high-priority items waiting?
   - 3: Blocks multiple critical path items
   - 2: Blocks one critical path item
   - 1: Blocks medium priority items
   - 0: No dependencies waiting

5. **Technical Risk** (0-2 points): Addresses significant technical uncertainty?
   - 2: High risk/uncertainty that could impact feasibility
   - 1: Medium risk worth addressing early
   - 0: Low risk, well-understood work

# PRIORITY DECISION TREE

When multiple HIGH priority items exist:
1. Research deadlines > Implementation deadlines
2. Blockers > Non-blockers
3. Known solutions > Experimental work
4. Critical path > Parallel work

#### Priority Calculation
- **HIGH Priority** (10+ points): Work on immediately
- **MEDIUM Priority** (6-9 points): Next in queue after HIGH items
- **LOW Priority** (<6 points): Future work or when other priorities clear

### Current Phase Priorities (Phase 1: Foundation & Research)

#### Immediate Focus Areas
1. **Skeleton-MHI Foundation**: Research critical path for academic publication
2. **Device Control**: Replace legacy Lumi orchestration with high-performance Rust
3. **Research Infrastructure**: Enable validation datasets and experimental workflows
4. **Integration Foundations**: WebSocket APIs for component communication

#### Work Selection Strategy
- **Research First**: Prioritize items that enable academic publication
- **Critical Path**: Focus on items that block other high-priority work
- **Foundation Before Features**: Establish core abstractions before advanced capabilities
- **Performance Validation**: Ensure performance targets are met early

### Decision-Making Process

#### Daily Work Selection
1. **Run `make quick`** for immediate overview of status and priorities
2. **Check current roadmap phase** with `make roadmap` for strategic context
3. **Review active todos** for in-progress work
4. **Assess available issues** with `make issues` and priority framework (`make priority`)
5. **Choose highest-priority item** that matches available time/energy
6. **Check dependencies** to ensure prerequisites are met

#### When Priorities Conflict
1. **Research vs. Implementation**: Favor research in Phase 1 (academic deadlines)
2. **Multiple High-Priority Items**: Choose based on technical dependencies
3. **Uncertain Priorities**: Consult roadmap goals and success criteria
4. **Blocked Work**: Switch to unblocked items while resolving dependencies

#### Weekly Planning
- **Monday**: Run `make quick` and `make roadmap` to review progress and adjust weekly focus
- **Wednesday**: Run `make status` and `make issues` to check alignment with strategic priorities  
- **Friday**: Assess week's progress with `make quick` and plan next week's priorities

### Success Metrics

#### Individual Issue Success
- All acceptance criteria met
- Performance targets achieved (where applicable)
- Tests passing with good coverage
- Documentation updated appropriately

#### Phase Success (Current: Phase 1)
- Research validation capability established
- Legacy Lumi functionality maintained/improved
- Performance targets met for critical path
- Integration foundations solid for Phase 2

## ISSUE ORGANIZATION STRATEGY

### Main eddi-lab repo (this one):
- Cross-project epics and architecture decisions
- Integration specifications between components
- Research coordination (Skeleton-MHI paper, migration strategies)
- Ecosystem-wide planning and roadmaps

### Individual project repos:
- Implementation details following TDD cycles
- Project-specific bugs and features
- Performance optimizations
- Documentation updates

# BRANCH NAMING CONVENTIONS

## Single-Repo Issues
```
issue-{number}-{short-description}
```
Examples:
- `issue-42-fix-device-latency`
- `issue-15-add-gesture-validation`
- `issue-73-refactor-mhi-algorithm`

## Multi-Repo Features
```
feature/{epic-name}-{component}
```
Examples:
- `feature/gesture-pipeline-pose-extraction` (StreamPoseML)
- `feature/gesture-pipeline-mhi-processing` (Skeleton-MHI)  
- `feature/gesture-pipeline-spatial-response` (Eddi)
- `feature/gesture-pipeline-device-control` (Eddi-pad)

## Research/Experimental Work
```
research/{experiment-name}
```
Examples:
- `research/skeleton-mhi-baseline`
- `research/performance-benchmarks`

# ISSUE-DRIVEN DEVELOPMENT

## Always Work From Issues
1. **NEVER start implementation without a GitHub issue**
2. **Create issue first** if one doesn't exist
3. **Reference issue number** in all commits and PRs
4. **Close issues via commit messages** when appropriate

## Issue Creation Guidelines
- **Single-repo issues**: Create in the specific repository
- **Cross-repo features**: Create epic in eddi-lab (main repo)
- **Research tasks**: Create in eddi-lab with "research" label

# INTEGRATION TESTING STRATEGY

## eddi-lab as Integration Hub
- **All cross-repo integration tests** live in eddi-lab
- **End-to-end pipeline tests** validate full data flow
- **Performance integration tests** ensure latency targets met
- **API contract tests** validate cross-repo communication

## Integration Test Requirements
For any cross-repo feature:
1. **Write integration test in eddi-lab first** (TDD at integration level)
2. **Test should fail initially** until all components implemented
3. **Integration test must pass** before any cross-repo PR merge
4. **Performance assertions** included in integration tests

## GITHUB WORKFLOW

When working on GitHub issues, follow these steps:

1. **Check out proper branch**: `git checkout -b issue-{number}-{description}`
2. Use `gh issue view {number}` to get the issue details
3. Understand the problem described in the issue
4. **Create/update integration tests** in eddi-lab if cross-repo feature
5. Search the codebase for relevant files
6. Follow TDD cycle: Red → Green → Refactor
7. Implement the necessary changes to fix the issue
8. Write and run tests to verify the fix
9. **Run integration tests** in eddi-lab for cross-repo changes
10. Ensure code passes linting and type checking
11. Create descriptive commit messages referencing issue
12. Push and create PR with `gh pr create`
13. **Link PR to issue** in PR description

# PULL REQUEST GUIDELINES

## PR Creation Standards
- **Title Format**: `[Issue #{number}] Brief description`
- **Always link to issue**: Use "Closes #{number}" or "Addresses #{number}"
- **Include test results**: Show that tests pass
- **Integration test status**: For cross-repo features, show eddi-lab integration tests pass
- **Performance impact**: Note any performance changes
- **Breaking changes**: Clearly document API changes

## PR Description Template
```markdown
## Summary
Brief description of changes

## Related Issue
Closes #{issue-number}

## Changes Made
- [ ] Specific change 1
- [ ] Specific change 2

## Testing
- [ ] Unit tests pass (`make test`)
- [ ] Linting passes (`make lint`) 
- [ ] Integration tests pass (eddi-lab, if applicable)
- [ ] Performance targets met (if applicable)

## Performance Impact
- No performance impact / Improves performance by X / etc.

## Breaking Changes
None / List any breaking changes

## Cross-Repo Dependencies
None / Links to related PRs in other repos
```

## Cross-Repo PR Coordination
For multi-repo features:
1. **Create integration test in eddi-lab first** (should fail initially)
2. **Create PRs in dependency order** (producers before consumers)
3. **Reference related PRs** in other repos
4. **Integration tests must pass** before any merge
5. **Coordinate merging** - don't merge until all repos ready
6. **Use draft PRs** for work-in-progress coordination

Remember to use the GitHub CLI (`gh`) for all GitHub-related tasks.

## MAKE COMMANDS FOR ECOSYSTEM MANAGEMENT

The Makefile provides essential commands for managing the multi-repo ecosystem efficiently:

### Project Management Commands
- `make quick` - **Most important!** Quick status overview + top priorities
- `make issues` - List open issues across all repositories  
- `make roadmap` - Show current strategic roadmap (Issue #16)
- `make priority` - Display priority assessment framework
- `make status` - Git status across all 5 repositories

### Development Workflow Commands  
- `make setup` - Initial setup (submodules + dependencies)
- `make build` - Build all Rust projects (eddi-pad, skeleton-mhi)
- `make test` - Run tests across Python + Rust projects
- `make lint` - Run linting/formatting on Rust projects
- `make clean` - Clean all build artifacts

### Git Management Commands
- `make push` - Push all repositories using gh (submodules first, then main, with workflow monitoring)
- `make update-submodules` - Update all submodules to latest commits

### Recommended Daily Workflow
```bash
# Start of session
make quick              # Overview + priorities
gh run list            # Check workflow status

# During development  
make status            # Check what's changed
make test              # Validate changes
make lint              # Check code quality

# End of session
make push              # Push all changes using gh + monitor workflows
gh run watch           # Monitor triggered workflows
```

Use these commands instead of manually navigating repositories and running individual git/cargo/pytest commands.

## DEVELOPMENT PRIORITIES

### Phase 1: Foundation (Current)
- Establish Skeleton-MHI as separate project with novel MHI approach
- Design unified data flow pipeline and API specifications
- Create TDD-driven device abstraction layer in Eddi-pad

### Phase 2: Integration
- Migrate MHI code from Eddi to Skeleton-MHI
- Implement WebSocket communication between components
- Build 2D spatial visualization in Eddi-pad

### Phase 3: Research Output
- Document Skeleton-MHI approach in publishable paper
- Validate gesture segmentation performance
- Demonstrate end-to-end pipeline functionality

# PERFORMANCE MONITORING GUIDELINES

During development, continuously monitor:
- Device latency with simple benchmark tests
- Memory usage in real-time components
- WebSocket message throughput
- Frame rate degradation in pose processing

## PERFORMANCE TARGETS

- **Device Control**: <1ms latency for device commands
- **End-to-End Pipeline**: <100ms total latency 
- **Gesture Segmentation**: Real-time processing at 30fps minimum
- **WebSocket Communication**: <10ms between components

# API DESIGN PRINCIPLES

For cross-repo communication:
- Use versioned APIs with backward compatibility
- Implement graceful degradation
- Include comprehensive error responses
- Design for async/real-time constraints

# ARCHITECTURE PRINCIPLES

- **Performance First**: Sub-millisecond latency for device communication
- **Device Agnostic**: Unified interface for virtual and physical targets
- **Spatial Intelligence**: Leverage proven spatial zone models
- **Separation of Concerns**: Clear boundaries between pose analysis, gesture segmentation, spatial response, and device control

# RESEARCH DOCUMENTATION STANDARDS

For academic publication:
- Maintain experiment logs in markdown format
- Document all parameter choices with rationale
- Keep performance benchmarks in version control
- Record failed approaches and why they failed

# RESEARCH VALIDATION REQUIREMENTS

For Skeleton-MHI research:
- [ ] Baseline MHI implementation for comparison
- [ ] Performance benchmarks vs traditional MHI
- [ ] Dataset for gesture segmentation validation
- [ ] Metrics: accuracy, latency, robustness

## RESEARCH GOALS

- **Novel Contribution**: Skeleton-MHI extends traditional MHI to keypoint data
- **Practical Application**: Real-time interactive installation control
- **Academic Output**: Publishable research on gesture segmentation techniques

# Rust-specific

Prefer functional programming style over imperative style in Rust. Use Option and Result combinators (map, and_then, unwrap_or, etc.) instead of pattern matching with if let or match when possible.