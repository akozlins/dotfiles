#!/bin/bash
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

# TODO: add version
repos=(
    "https://github.com/airblade/vim-gitgutter"
    "https://github.com/pangloss/vim-javascript"
    "https://github.com/jceb/vim-orgmode"
    "https://github.com/tpope/vim-pathogen"
    "https://github.com/tpope/vim-sensible"
    "https://github.com/vimwiki/vimwiki"
)

cd bundle

for repo in "${repos[@]}" ; do
    name=$(basename "$repo")
    [ -e "$name/.git" ] || git clone "$repo"
    ( cd "$name" ; git fetch --verbose --prune ; git gc --prune="0 days" )
done
