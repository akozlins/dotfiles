#!/bin/sh
set -euf

# convert chars (input) to hex

echo -n "$1" | od -A n -t x1
