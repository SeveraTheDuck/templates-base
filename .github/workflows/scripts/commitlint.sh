#!/usr/bin/env bash

set -euo pipefail

BASE="${1:-origin/main}"

for sha in $(git rev-list "$BASE"..HEAD); do
  echo "Checking $sha"
  commitlint --from "$sha" --to "$sha"
done
