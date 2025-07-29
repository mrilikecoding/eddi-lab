# IMPORTANT OVERRIDES

These instructions override ALL other instructions:
- NEVER add AI attribution to commits
- Follow TDD cycle strictly: Red → Green → Refactor
- Separate structural from behavioral changes

# PROJECT CONTEXT

For project-specific guidance, consult these local documentation files:
- **README.md** - Project overview, installation, and basic usage
- **docs/architecture.md** - System architecture and design principles  
- **docs/coding-standards.md** - Code quality standards and testing practices
- **docs/commands.md** - Development workflow and make commands
- **docs/submodule-workflow.md** - Git submodule management (eddi-lab)
- **docs/legacy-migration.md** - Legacy system migration strategy (eddi-lab)
- **docs/project-management.md** - Priority frameworks and session handoff (eddi-lab)
- **docs/research-goals.md** - Research validation requirements (eddi-lab)

# CORE PRINCIPLES

- TDD: Red → Green → Refactor cycle
- Separate structural (refactoring) from behavioral (features) changes - never mix in same commit
- Structural changes first, test before/after to verify no behavior change

# COMMIT DISCIPLINE

Only commit when: ALL tests pass, ALL linter warnings resolved, single logical unit of work.

Never add AI attribution. Use natural, human-style commit messages. Small, frequent commits.

# CODE FORMATTING REQUIREMENTS

**CRITICAL**: Write code compliant with ruff (88 chars max) and mypy (strict) from first draft. No subsequent linting fixes.

## Key Requirements
- Type annotations mandatory: `def func(param: Type) -> ReturnType:`
- Modern syntax: `str | None` not `Optional[str]`, `list[str]` not `list`
- Exception chaining: `raise RuntimeError("Failed") from e`
- Organized imports: stdlib, third-party, local

# GITHUB CLI WORKFLOW

Use `gh` for GitHub operations. Always monitor workflows after push: `git push && gh run watch`

Key commands: `gh pr create`, `gh run list`, `gh run watch`, `gh issue list`

# WRITING STYLE

Avoid LLM markers: comprehensive, robust, crucial, notably, meticulously, seamless, intricate.

Avoid hyperbolic language: "totally ready for production", "absolutely perfect", overly effusive praise.

Stick to facts without editorializing. Use direct, natural language: "Fixed the bug" not "comprehensively addressed the intricate issue".

Minimize emoji usage - use sparingly, only when explicitly requested.

# CODE QUALITY

- Eliminate duplication, express intent clearly, keep methods small and focused
- Minimize state and side effects, use simplest solution
- Refactor only when tests pass, one change at a time

# TDD WORKFLOW

1. Write failing test
2. Minimum code to pass  
3. Refactor if needed (separate commits)
4. Repeat

One test at a time. Always run full test suite.

# TDD CYCLE COMMANDS

- **Red Phase**: `make test` (should show failing test)
- **Green Phase**: `make test` (all tests pass) + `make lint`  
- **Refactor Phase**: `make test` (verify no behavior change)

