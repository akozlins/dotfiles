#!/bin/sh
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

APPS_DIR="$XDG_DATA_HOME/applications"
mkdir -pv -- "$APPS_DIR"

find "$(pwd)" -name "*.in" | while read -r fin ; do
    fout=$APPS_DIR/$(basename -- "$fin" .in)
    echo "I [] envsubst > $fout"
    envsubst < "$fin" > "$fout"
done
