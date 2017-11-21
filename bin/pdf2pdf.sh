#!/bin/sh
set -euf

input="$1"
output="$2"

exec \
gs \
-sDEVICE=pdfwrite \
-dPDFSETTINGS=/prepress \
-dCompatibilityLevel=1.4 \
-o "$output" "$input"
