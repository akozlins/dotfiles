#!/bin/bash
set -euf
export LC_ALL=C

# list all objects (blobs, etc.) and sort by size

# output: hash type size name

OPTS=${1:---all}

join \
    <(git cat-file --batch-all-objects --batch-check | sort) \
    <(git rev-list --objects $OPTS | sort) \
    | sort -nk3
