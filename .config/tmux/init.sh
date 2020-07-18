#!/bin/bash
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

[ -e plugins ] || mkdir -pv "$(readlink -- plugins)"
[ -e resurrect ] || mkdir -pv "$(readlink -- resurrect)"

# TODO: add version
repos=(
    "https://github.com/tmux-plugins/tpm"
)

cd plugins || exit 1

for repo in "${repos[@]}" ; do
    name=$(basename -- "$repo")
    if [ ! -d "$name/.git" ] ; then
        rm -rfv -- "$name"
        git clone "$repo"
    fi
    ( cd "$name" ; git fetch --verbose )
done
