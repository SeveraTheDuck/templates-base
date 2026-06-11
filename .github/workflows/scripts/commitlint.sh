#!/usr/bin/env bash

set -euo pipefail

BASE="${1:-origin/main}"

for sha in $(git rev-list "$BASE"..HEAD); do
  # Skip merge commits
  if [ "$(git cat-file -p "$sha" | grep -c '^parent')" -gt 1 ]; then
    echo "Skipping merge commit $sha"
    continue
  fi
  echo "Checking $sha"
  commitlint --from "$sha" --to "$sha"
done
