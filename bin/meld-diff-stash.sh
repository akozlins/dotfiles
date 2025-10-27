#!/bin/bash
set -euf

exec \
meld \
    <(git diff --ignore-all-space | sed -e '/^index/d' -e 's/^@@.*$/@@/g') \
    <(git stash show -p --ignore-all-space | sed -e '/^index/d' -e 's/^@@.*$/@@/g') \
    --
