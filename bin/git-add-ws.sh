#!/bin/bash
set -euf
export LC_ALL=C

# add all whitespace chages

pathspec=${1:-:/}
git add --update -- "$pathspec"
git diff --cached --ignore-all-space --ignore-blank-lines \
    | git -C "$(git rev-parse --show-toplevel)" apply --cached --reverse
