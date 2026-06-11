# templates-base

Opinionated base template for production-ready pet projects.

[![CI](https://github.com/SeveraTheDuck/templates-base/actions/workflows/ci.yaml/badge.svg)](https://github.com/SeveraTheDuck/templates-base/actions/workflows/ci.yaml)
[![Release](https://img.shields.io/github/v/release/SeveraTheDuck/templates-base)](https://github.com/SeveraTheDuck/templates-base/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSES/MIT.txt)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com)

## What's included

- **Dev environment** — Nix + direnv, zero manual setup
- **Formatting** — treefmt (taplo, shfmt, nixfmt, yamlfmt, jq)
- **Linting** — typos, reuse lint, commitlint (Conventional Commits)
- **CI** — GitHub Actions: lint, commitlint, gitleaks, release-please, SBOM
- **Releases** — automated CHANGELOG, version.txt, GitHub releases via release-please
- **License compliance** — REUSE/SPDX, supports MIT, Apache-2.0, GPL-3.0-only
- **Dependency updates** — Renovate Bot (weekly, grouped)

## Prerequisites

- [Nix](https://nixos.org/download/) with flakes enabled
- [direnv](https://direnv.net/)
- [Copier](https://copier.readthedocs.io/) — `nix shell nixpkgs#copier`

## Usage

Generate a new project from this template:

```bash
copier copy gh:SeveraTheDuck/templates-base my-project
```

You will be asked:

| Question | Description |
|----------|-------------|
| `project_name` | Project name (e.g. `my-project`) |
| `project_description` | One-line description |
| `github_owner` | GitHub username or organization |
| `author` | Copyright holder (defaults to `github_owner`) |
| `license` | `MIT`, `Apache-2.0`, or `GPL-3.0-only` |

Enable `direnv` and see `just` command options:

```bash
cd my-project
direnv allow
just
```

## Updating a generated project

```bash
cd my-project
copier update
```

Or automatically via the weekly `update-template.yaml` workflow that runs in generated projects.

## Architecture

This is the base layer of a composable template system:

```
templates-base          ← this repo, language-agnostic foundation
# more available soon
```

Language and feature templates are layered on top via Copier's `_inherit_from`.

## Documentation

- [Contributing](CONTRIBUTING.md)
- [Releasing](docs/releasing.md)
- [Architecture Decision Records](docs/adr/README.md)

## License

[MIT](LICENSES/MIT.txt) © Alexander Antipov
