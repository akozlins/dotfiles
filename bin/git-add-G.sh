#!/bin/bash
set -euf
export LC_ALL=C

TOP=$(git rev-parse --show-toplevel)

files=(
    $(git -C "$TOP" diff --name-only -G "$1")
)

for file in "${files[@]}" ; do
    git -C "$TOP" add -p "$file"
done
