# Apache Flink Course

Coursework and examples for learning Apache Flink and its JVM ecosystem.

## Development environment

The supported local development environment is macOS with Zsh. Python runs the
repository development tools; it does not make this repository a Python
application. Java is the runtime for the Flink course code.

The repository requires:

- Python 3.13
- Any JDK 17 distribution, such as Amazon Corretto, Eclipse Temurin, BellSoft
  Liberica, or OpenJDK
- [Homebrew](https://brew.sh/)
- Git and the Xcode Command Line Tools

The `.python-version` and `.java-version` files select runtimes that are already
installed. They do not install Python or Java.

### Configure a Mac

Install the Xcode Command Line Tools if they are not already present:

```bash
xcode-select --install
```

After installing Homebrew, install the runtime managers and Python tool runner:

```bash
brew install pyenv jenv pipx
```

Add pyenv and jenv to Zsh:

```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
exec "$SHELL" -l
```

Install Python 3.13. Pyenv resolves `3.13` to the latest available Python 3.13
patch release:

```bash
pyenv install 3.13
```

Install a JDK 17 distribution from the vendor of your choice or through
Homebrew. Register the installed JDK with jenv, then enable automatic
`JAVA_HOME` configuration:

```bash
/usr/libexec/java_home -V
jenv add "$(/usr/libexec/java_home -v 17)"
jenv enable-plugin export
exec "$SHELL" -l
```

If more than one JDK 17 is installed, pass the desired JDK home directory to
`jenv add` explicitly. The repository selects jenv's `17` alias and does not
require a particular vendor or patch release.

### Configure a fresh clone

From the cloned repository directory, install the pinned development tools and
Git hooks:

```bash
pipx install --python "$(pyenv which python)" "commitizen==4.18.0"
pipx install --python "$(pyenv which python)" "pre-commit==4.6.1"
pre-commit install
```

The repository configuration installs the `pre-commit`, `commit-msg`, and
`pre-push` hooks. Run `pre-commit install` for every new clone.

Verify the selected runtimes and tools:

```bash
python --version
java -version
echo "$JAVA_HOME"
cz version
pre-commit --version
pre-commit run --all-files
```

Python must report `3.13.x`, Java must report `17.x`, and `JAVA_HOME` must point
to the JDK selected by jenv.

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
