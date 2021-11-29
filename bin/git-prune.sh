#!/bin/sh
set -euf

git submodule foreach --recursive "git gc --prune='0 days'"
git gc --prune='0 days' "$@"
