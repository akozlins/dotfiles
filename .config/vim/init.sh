#!/bin/bash
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

[ -e bundle ] || mkdir -vp "$(readlink -- bundle)"

# TODO: use vim plug

# TODO: add version
repos=(
    "https://github.com/airblade/vim-gitgutter"
    "https://github.com/pangloss/vim-javascript"
    "https://github.com/jceb/vim-orgmode"
    "https://github.com/tpope/vim-pathogen"
    "https://github.com/tpope/vim-sensible"
    "https://github.com/vimwiki/vimwiki"
)

cd bundle || exit 1

for repo in "${repos[@]}" ; do
    name=$(basename -- "$repo")
    if [ ! -d "$name/.git" ] ; then
        rm -rf -- "$name"
        git clone "$repo"
    fi
    ( cd "$name" ; git fetch --verbose --prune )
done
