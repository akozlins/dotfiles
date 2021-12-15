#!/bin/sh
set -euf

# <https://git-scm.com/docs/git-gc>

git submodule foreach --recursive "git gc --prune='0 days'"
git gc --prune='0 days' "$@"
