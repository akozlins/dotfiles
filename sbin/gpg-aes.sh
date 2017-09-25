#!/bin/sh
set -euf

input="$1"
output="$2"

exec \
gpg \
-acvv \
--s2k-cipher-algo AES-256 \
--s2k-digest-algo SHA256 \
--s2k-mode 3 --s2k-count $((1024*1024)) \
-o "$input" "$output"
