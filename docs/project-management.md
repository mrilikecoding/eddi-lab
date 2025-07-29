# Project Management Guidelines

## Issue Selection Framework

When choosing what to work on next, evaluate issues using this priority matrix:

### Priority Assessment Criteria

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

### Priority Decision Tree

When multiple HIGH priority items exist:
1. Research deadlines > Implementation deadlines
2. Blockers > Non-blockers
3. Known solutions > Experimental work
4. Critical path > Parallel work

### Priority Calculation
- **HIGH Priority** (10+ points): Work on immediately
- **MEDIUM Priority** (6-9 points): Next in queue after HIGH items
- **LOW Priority** (<6 points): Future work or when other priorities clear

## Current Phase Priorities (Phase 1: Foundation & Research)

### Immediate Focus Areas
1. **Skeleton-MHI Foundation**: Research critical path for academic publication
2. **Device Control**: Replace legacy Lumi orchestration with high-performance Rust
3. **Research Infrastructure**: Enable validation datasets and experimental workflows
4. **Integration Foundations**: WebSocket APIs for component communication

### Work Selection Strategy
- **Research First**: Prioritize items that enable academic publication
- **Critical Path**: Focus on items that block other high-priority work
- **Foundation Before Features**: Establish core abstractions before advanced capabilities
- **Performance Validation**: Ensure performance targets are met early

## Decision-Making Process

### Daily Work Selection
1. **Run `make quick`** for immediate overview of status and priorities
2. **Check current roadmap phase** with `make roadmap` for strategic context
3. **Review active todos** for in-progress work
4. **Assess available issues** using `make issues` and priority framework (`make priority`)
5. **Choose highest-priority item** that matches available time/energy
6. **Check dependencies** to ensure prerequisites are met

### When Priorities Conflict
1. **Research vs. Implementation**: Favor research in Phase 1 (academic deadlines)
2. **Multiple High-Priority Items**: Choose based on technical dependencies
3. **Uncertain Priorities**: Consult roadmap goals and success criteria
4. **Blocked Work**: Switch to unblocked items while resolving dependencies

### Weekly Planning
- **Monday**: Run `make quick` and `make roadmap` to review progress and adjust weekly focus
- **Wednesday**: Run `make status` and `make issues` to check alignment with strategic priorities
- **Friday**: Assess week's progress with `make quick` and plan next week's priorities

## Session Handoff Protocol

### Ending a Claude Code Session
1. **Run `make quick`** to document current state
2. **Update TodoWrite** with session progress and next priorities
3. **Commit all WIP** with clear "WIP:" prefixes and issue references
4. **Document important context** in TodoWrite (decisions made, integration dependencies discovered)
5. **Note any blockers** or prerequisites for next session
6. **Push branches** to preserve work across sessions

### Starting a Claude Code Session
1. **Quick overview**: Run `make quick` to see status and top priorities
2. **Check TodoRead** to see current task status and session context
3. **Review available work**: Run `make issues` to see all open issues
4. **Consult roadmap**: Run `make roadmap` to understand current phase and strategic priorities
5. **Select work using priority framework** (run `make priority` for criteria)
6. **Follow TDD cycle** for all development work

### Context Preservation
- **Use TodoWrite as session memory** - record decisions, discoveries, blockers
- **WIP commits preserve state** - never lose work between sessions
- **Branch naming includes issue context** - easy to resume work
- **Integration test status** shows cross-repo progress

## Issue Organization Strategy

### Main eddi-lab repo:
- Cross-project epics and architecture decisions
- Integration specifications between components
- Research coordination (Skeleton-MHI paper, migration strategies)
- Ecosystem-wide planning and roadmaps

### Individual project repos:
- Implementation details following TDD cycles
- Project-specific bugs and features
- Performance optimizations
- Documentation updates

### Branch Naming Conventions

**Single-Repo Issues:** `issue-{number}-{short-description}`
- `issue-42-fix-device-latency`
- `issue-15-add-gesture-validation`

**Multi-Repo Features:** `feature/{epic-name}-{component}`
- `feature/gesture-pipeline-pose-extraction` (StreamPoseML)
- `feature/gesture-pipeline-spatial-response` (Eddi)

**Research Work:** `research/{experiment-name}`
- `research/skeleton-mhi-baseline`

### Issue-Driven Development
- **Always work from GitHub issues** - create if none exists
- **Reference issue numbers** in commits and PRs
- **Close via commit messages** when appropriate
- **Single-repo issues**: Create in specific repository
- **Cross-repo features**: Create epic in eddi-lab

## Success Metrics

### Individual Issue Success
- All acceptance criteria met
- Performance targets achieved (where applicable)
- Tests passing with good coverage
- Documentation updated appropriately

### Phase Success (Current: Phase 1)
- Research validation capability established
- Legacy Lumi functionality maintained/improved
- Performance targets met for critical path
- Integration foundations solid for Phase 2