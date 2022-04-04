#!/bin/sh
set -euf

exec \
vboxmanage \
    internalcommands createrawvmdk \
    -filename "$1" \
    -rawdisk "$2" \
    "$@"
