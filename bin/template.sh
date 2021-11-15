#!/bin/sh
set -euf
#set -o errexit -o nounset

IFS="$(printf '\n\t')"
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

PATH="$(command -p getconf PATH)"
export PATH

DOTFILES="${DOTFILES:-~/.dotfiles}"
test -d "$DOTFILES" && export HOME="$DOTFILES"

exec \
true "$@"
