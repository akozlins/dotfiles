#!/bin/bash
set -euf

ROOT="${1:-$(pwd)}"
PATTERN="^\\.exclude\$"

# find .exclude files and generate ignore patterns
while IFS='' read -r file ; do
    dir=$(dirname -- "$file")
    printf "ignore = String '%s'\n" "$dir"
done < <(fd --hidden "$PATTERN" "$ROOT")

# TODO: read .ignore files

#unison "$@" -source "exclude.prf"
