#!/bin/sh

DOTFILES=$(dirname -- "$(readlink -e -- "$HOME/.profile")")
export DOTFILES
. "$DOTFILES/envrc"
export PATH="$DOTFILES/bin:$PATH"
