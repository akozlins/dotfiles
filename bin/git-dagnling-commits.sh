#!/bin/sh
set -euf

git fsck --no-reflogs \
| awk '/dangling commit/{print $3}' \
| xargs git --no-pager show -s --format="%cI %h '%s'" \
| sort
