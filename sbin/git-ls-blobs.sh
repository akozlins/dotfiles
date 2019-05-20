#!/bin/bash
set -euf

join \
    <(git cat-file --batch-all-objects --batch-check | sort) \
    <(git rev-list --all --objects | sort) \
    | sort -nrk3
