#!/bin/bash
set -euf
#set -o errexit -o nounset -o noglob

IFS="$(printf '\n\t')"
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

PATH="$(command -p getconf PATH)"
export PATH

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
[ -d "$DOTFILES" ] && export HOME="$DOTFILES"

CMD=(
    sleep 1
    "$@"
)

[ $# -ge 0 ] && exec "${CMD[@]}"
"${CMD[@]}" &> /dev/null &
