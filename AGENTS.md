# Repository Working Agreement

These instructions apply to every task in this repository.

## Start safely

- Before making changes, run `git branch --show-current` and
  `git status --short --branch`.
- Treat `main` as read-only. Never edit, commit, or push directly from `main`.
- Fetch the latest `origin/main`, then create a branch that follows the naming
  convention in `README.md` before editing files.
- Give each unrelated change its own branch. Prefer separate worktrees when
  working on independent changes at the same time.
- Do not reuse a branch whose pull request has already been merged.
- Preserve user changes and unrelated work already present in a worktree.

## Implement and verify

- State the acceptance cases before implementation. Include cases requested by
  the user and any additional cases needed to cover likely failures.
- Keep changes focused on the requested outcome. Update documentation when
  setup, behavior, or workflows change.
- Run the relevant existing checks and tests before committing. Add tests when
  they provide meaningful coverage; documentation-only changes normally rely on
  repository checks rather than new tests.
- Follow the Conventional Commit format configured in `.cz.toml`.
- After committing, verify the commit range and diff against `origin/main`, the
  check results, and a clean working tree.

## Deliver for review

- Push the completed branch and open a draft pull request against `main` using
  `.github/pull_request_template.md`.
- When review feedback arrives, read every review summary, inline comment, and
  question. Address each item in the branch or explain why no change is needed.
- Reply directly to every review thread with the answer, rationale, and relevant
  commit. Updating the code without replying does not answer the reviewer.
- Rerun the relevant checks after review changes and wait for required CI checks
  to pass. Leave review threads unresolved so the reviewer can confirm the
  response unless the user asks you to resolve them.
- Before reporting that review work is complete, confirm that every substantive
  question and comment has a direct response and that all requested changes are
  ready for approval.
- Keep the pull request in draft state so the user can review it and decide when
  it is ready. Do not mark it ready or merge it.
- Report the branch, commit, checks run, draft pull request link, and any
  material limitations.
