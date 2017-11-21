#!/bin/sh
set -euf

input="$1"
output="$2"

exec \
convert \
-define pdf:use-cropbox=true \
-density 150 \
"$input" "$output"
