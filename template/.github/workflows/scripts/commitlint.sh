#!/usr/bin/env bash

set -euo pipefail

BASE="${1:-origin/main}"

for sha in $(git rev-list "$BASE"..HEAD); do
  # Skip merge commits
  if [ "$(git cat-file -p "$sha" | grep -c '^parent')" -gt 1 ]; then
    echo "Skipping merge commit $sha"
    continue
  fi

  # Skip release-please commits
  if git log --format="%s" -n 1 "$sha" | grep -q '^chore(main): release'; then
    echo "Skipping release commit $sha"
    continue
  fi

  echo "Checking $sha"
  commitlint --from "$sha-1" --to "$sha"
done
