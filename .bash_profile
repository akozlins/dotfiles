#!/bin/sh

DOTFILES=$(dirname -- "$(readlink -e -- "$HOME/.bash_profile")")
export DOTFILES
. "$DOTFILES/envrc"
export PATH="$DOTFILES/bin:$PATH"
