#!/bin/bash
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

mkdir -vp ~/.cache/tmux/plugins
ln -vsf ~/.cache/tmux/plugins
mkdir -vp ~/.cache/tmux/resurrect
ln -vsf ~/.cache/tmux/resurrect

# TODO: add version
repos=(
    "https://github.com/tmux-plugins/tpm"
)

cd plugins || exit 1

for repo in "${repos[@]}" ; do
    name=$(basename -- "$repo")
    if [ ! -d "$name/.git" ] ; then
        rm -rf -- "$name"
        git clone "$repo"
    fi
    ( cd "$name" ; git fetch --verbose )
done
