#!/bin/bash
set -euf
export LC_ALL=C

# add all whitespace chages

ROOT=$(git rev-parse --show-toplevel)
cd -- "$ROOT"
git add --update
git diff --cached --ignore-all-space | git apply --cached --reverse
