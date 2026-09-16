# Apache Flink Course

Coursework and examples for learning Apache Flink and its JVM ecosystem.

## Commit conventions

This repository uses [Conventional Commits](https://www.conventionalcommits.org/)
with the following format:

```text
<type>[optional scope][!]: <description>
```

Allowed types are `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
`build`, `ci`, and `revert`. The `chore` type is intentionally not allowed.
Commit headers may contain at most 72 characters.

Examples:

```text
feat(source): add a Kafka event source
fix(window)!: change late-event handling
docs: explain event-time semantics
```

Scopes are optional and should be lowercase. Breaking changes use `!` and
should explain the impact in a `BREAKING CHANGE:` footer.

### Install the developer tools

The tools run in isolated Python environments and do not make this a Python
application. Install Python 3.10 or newer and
[pipx](https://pipx.pypa.io/) using your operating system's package manager,
then run:

```bash
pipx install --python python3.13 "commitizen==4.18.0"
pipx install --python python3.13 "pre-commit==4.6.1"
pre-commit install
```

The repository configuration installs both the `pre-commit` and `commit-msg`
hooks. Re-run `pre-commit install` after cloning the repository on another
machine.

Use the interactive commit prompt:

```bash
cz commit
```

Normal `git commit` commands also work, but invalid messages are rejected by
the `commit-msg` hook. Run all repository checks manually with:

```bash
pre-commit run --all-files
```

Git hooks can technically be bypassed with `--no-verify`; GitHub Actions remains
the authoritative check for pull request titles, every commit in a pull request,
and pushes to `main`.

## Branch conventions

Branch names use the following format:

```text
<type>/<lowercase-kebab-description>
```

Allowed branch types are `feat`, `fix`, `docs`, `style`, `refactor`, `perf`,
`test`, `build`, `ci`, `revert`, and `section`. The `section` type groups work
for a course section while following the same naming structure as other
branches.

Examples:

```text
build/initial-repository-setup
section/event-time-and-watermarks
feat/kafka-event-source
fix/late-event-handling
```

The `pre-push` hook rejects invalid branch names and direct pushes to `main`.
GitHub Actions applies the same branch-name validation to pull requests. Create
commits on a review branch and open a pull request to merge them into `main`.

### Recommended GitHub settings

Protect `main` with these repository settings:

- Require the `Validate commits and repository files` status check.
- Require a linear history.
- Disable merge commits and enable rebase merging.
- Prevent direct pushes to `main` for contributors who should use pull requests.

### Tooling roadmap

- [x] Conventional commit prompts and validation
- [x] Generic formatting and repository-safety checks
- [x] Pull request commit and title validation
- [ ] Gitleaks secret scanning
- [ ] Language-specific static analysis after choosing Scala or Java
- [ ] Dependency vulnerability scanning after choosing Maven or Gradle
- [ ] A development container when reproducing the complete toolchain becomes useful
