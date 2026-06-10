#!/usr/bin/env bash

set -euo pipefail

for sha in $(git rev-list origin/main..HEAD); do
  echo "Checking $sha"
  git log --format=%B -n 1 "$sha" | commitlint --stdin
done
