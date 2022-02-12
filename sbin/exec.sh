#!/bin/sh
set -euf

if [ "$0" = "$BASH_SOURCE" ] ; then
    >&2 echo "E [$0] this script must be sourced"
    exit 1
fi

program_path=$(readlink -f -- "$0")
program_name=$(basename -- "$program_path")

for executable in $("$DOTFILES/sbin/which" "$program_name") ; do
    executable=$(readlink -f -- "$executable")
    [ "$program_path" = "$executable" ] && continue
    exec "$executable" "$@"
done

PATH="$(command -p getconf PATH)"

exec \
"$program_name" "$@"
