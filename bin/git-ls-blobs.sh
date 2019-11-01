#!/bin/bash
set -euf
export LC_ALL=C

# list all objects (blobs, etc.) and sort by size

join \
    <(git cat-file --batch-all-objects --batch-check | sort) \
    <(git rev-list --all --objects | sort) \
    | sort -nk3
