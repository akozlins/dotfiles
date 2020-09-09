#!/bin/sh
set -euf

program_path=$(readlink -f -- "$0")
program_name=$(basename -- "$program_path")

for executable in $(which -a -- "$program_name") ; do
    executable=$(readlink -f -- "$executable")
    [ "$program_path" = "$executable" ] && continue
    exec \
    "$executable" "$@"
done



PATH="$(command -p getconf PATH)"

exec \
"$program_name" "$@"
