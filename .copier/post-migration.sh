#!/usr/bin/env bash

# This file basically ensures safe upgrades between template versions.
# It removes obsolete files, renames moved ones, and warns about breaking
# changes that Copier cannot handle automatically.

# Runs after `copier update`
#
# Copier executes this script from the root of the destination project.
# Available env vars:
#   COPIER_ANSWERS_FILE  — path to the answers file (.copier/answers.base.yaml)
#
# Convention for adding migrations:
#   1. Add a version-gated block below (see example)
#   2. prev_version is the _commit value BEFORE the update
#   3. Keep blocks in ascending version order
#   4. Prefer `git mv` / `rm` over manual instructions where possible

set -euo pipefail

answers_file="${COPIER_ANSWERS_FILE:-.copier/answers.base.yaml}"

# Extract the previous version from the answers file
prev_version=$(grep '^_commit:' "$answers_file" | awk '{print $2}' | tr -d '"')

echo "ℹ post-migration: previous version was ${prev_version:-unknown}"

# --- Migrations ---------------------------------------------------------------
#
# Template:
#
#   if version_lt "$prev_version" "X.Y.Z"; then
#     echo "migrating from <X.Y.Z: ..."
#     <commands>
#   fi

version_lt() {
  [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ] && [ "$1" != "$2" ]
}

# (no migrations yet)

echo "post-migration complete"
