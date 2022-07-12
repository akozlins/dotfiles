#!/bin/sh
set -euf

# delete file from git repository

path=$1
shift

exec \
git filter-branch \
    --index-filter \
    "git rm -rf --cached --ignore-unmatch -- $path" \
    "$@"
