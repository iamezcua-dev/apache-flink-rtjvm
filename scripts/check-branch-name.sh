#!/bin/sh

set -eu

branch_name=${1:-${PRE_COMMIT_REMOTE_BRANCH:-}}

if [ -z "$branch_name" ]; then
  branch_name=$(git symbolic-ref --quiet --short HEAD) || {
    echo "Unable to determine the branch name." >&2
    exit 1
  }
fi

case ${PRE_COMMIT_LOCAL_BRANCH:-} in
  '(delete)' | delete)
    exit 0
    ;;
esac

case ${PRE_COMMIT_TO_REF:-} in
  0000000000000000000000000000000000000000)
    exit 0
    ;;
esac

case $branch_name in
  refs/tags/*)
    exit 0
    ;;
  refs/heads/*)
    branch_name=${branch_name#refs/heads/}
    ;;
esac

if [ "$branch_name" = main ]; then
  echo "Direct pushes to main are not allowed; push a review branch instead." >&2
  exit 1
fi

pattern='^(feat|fix|docs|style|refactor|perf|test|build|ci|revert|section)/[a-z0-9]+(-[a-z0-9]+)*$'

if ! LC_ALL=C grep -Eq "$pattern" <<EOF
$branch_name
EOF
then
  echo "Invalid branch name: $branch_name" >&2
  echo "Expected <type>/<lowercase-kebab-description>." >&2
  echo "Allowed types: feat, fix, docs, style, refactor, perf, test, build, ci, revert, section." >&2
  exit 1
fi

echo "Branch name is valid: $branch_name"
