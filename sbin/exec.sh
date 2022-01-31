#!/bin/bash
set -euf

if [ "$0" = "$BASH_SOURCE" ] ; then
    >&2 echo "E [$0] this script must be sourced"
    exit 1
fi

program_path=$(readlink -f -- "$0")
program_name=$(basename -- "$program_path")

while IFS='' read -r executable ; do
    executable=$(readlink -f -- "$executable")
    [ "$program_path" = "$executable" ] && continue
    exec \
    "$executable" "$@"
done < <("$DOTFILES/sbin/which" -- "$program_name")



PATH="$(command -p getconf PATH)"

exec \
"$program_name" "$@"
