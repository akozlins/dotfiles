#!/bin/bash
set -euf

from="$1"
to="$2"

docker volume create --name "$to"

COPY=(
    docker run
    # remove the container when it exits
    --rm
    # keep stdin open
#    --interactive
    # allocate pseudo-TTY
    --tty
    -v "$from:/from"
    -v "$to:/to"
    # image
    alpine
    # command
    sh -c "cp -av /from/. /to/"
)

exec "${COPY[@]}"
