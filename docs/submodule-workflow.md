# Git Submodule Workflow

## Error Recovery Procedures

### Build/Test Failures
When builds/tests fail:
1. Never commit broken code - fix or revert immediately
2. Use git bisect for regression hunting across repos
3. Maintain known-good commit SHAs for each repo
4. Have rollback procedures for each integration point

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

## Branch Management Rules

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

## Development Workflow

### Starting Work on Cross-Repo Feature
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

### Committing Submodule Changes
```bash
# 1. Commit in submodule first
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

### Avoiding Detached HEAD States
- **NEVER use `git submodule update` without `--remote` on existing work**
- **ALWAYS check branch status after submodule operations**
- **Use `git submodule foreach` for batch branch operations**

## Troubleshooting

### If Submodule is in Detached HEAD:
```bash
cd problematic-submodule
git checkout main  # or appropriate branch
git pull origin main
cd ..
git add problematic-submodule
git commit -m "Fix detached HEAD in problematic-submodule"
```

### Clean Slate Setup (for new clones):
```bash
# Complete fresh setup
git clone --recurse-submodules https://github.com/user/eddi-lab.git
cd eddi-lab
git submodule foreach 'git checkout main'
git submodule foreach 'git pull origin main'
```

## Enhanced Workflow Monitoring

### Monitoring Commands
- `make push-with-monitoring` - Detached HEAD detection, individual submodule push with status
- `make workflow-status` - Ecosystem-wide health dashboard
- `make watch-workflows` - Active run detection across repositories  
- `make workflow-failures` - Recent failure analysis with debug commands

### Safe Push Operations
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