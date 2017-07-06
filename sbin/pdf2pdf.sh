#!/bin/sh
set -euf -o pipefail

input="$1"
output="$2"

exec \
gs \
-sDEVICE=pdfwrite \
-dPDFSETTINGS=/prepress \
-dCompatibilityLevel=1.4 \
-o "$output" "$input"
