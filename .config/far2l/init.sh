#!/bin/sh
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

find . -type l | while read -r link ; do
    target=$(readlink -f -- "$link")
    mkdir -pv -- "$target"
done
