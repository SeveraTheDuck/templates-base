# Format all files
fmt:
    treefmt

# Check formatting without modifying files
fmt-check:
    treefmt --fail-on-change

# Run all linters
lint:
    typos
    reuse lint

# Run everything as in CI
ci: fmt-check lint

# Show unreleased changes since the last tag
changelog:
    git log $(git describe --tags --abbrev=0)..HEAD --oneline

# Check service health (override in lang.just)
health:
    @echo "error: 'health' is not implemented for this project" && exit 1

# Generate coverage report (override in lang.just)
coverage:
    @echo "error: 'coverage' is not implemented for this project" && exit 1
