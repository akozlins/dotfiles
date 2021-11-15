#!/bin/bash
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

APPS_DIR="${XDG_DATA_HOME:-~/.local/share}/applications"
mkdir -pv -- "$APPS_DIR"

cp -v -- mimeapps.list "$APPS_DIR/"

find . -name "*.in" | while read -r fin ; do
    fout=$(basename -- "$fin" .in)
    echo "I [] envsubst > $APPS_DIR/$fout"
    envsubst < "$fin" > "$APPS_DIR/$fout"
done
