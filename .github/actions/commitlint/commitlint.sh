#!/usr/bin/env bash
set -euo pipefail
nix shell nixpkgs#commitlint-rs --command commitlint --from "$FROM" --to "$TO"
