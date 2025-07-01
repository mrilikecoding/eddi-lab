.PHONY: help setup update-submodules install-dev test clean

help:
	@echo "Available commands:"
	@echo "  setup           - Initial setup of development environment"
	@echo "  update-submodules - Update all submodules to latest"
	@echo "  install-dev     - Install all packages in development mode"
	@echo "  test           - Run all tests"
	@echo "  clean          - Clean build artifacts"

setup: update-submodules install-dev

update-submodules:
	git submodule update --remote --merge

install-dev:
	# Install Python packages in editable mode
	pip install -e ./StreamPoseML
	pip install -e ./eddi
	# add others
	# cd rust-tool && cargo build

test:
	# Run tests for each component
	cd StreamPoseML && python -m pytest
	cd eddi && python -m pytest
	# Run integration tests
	python -m pytest integration-tests/

clean:
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete
	find . -name "*.egg-info" -exec rm -rf {} +
