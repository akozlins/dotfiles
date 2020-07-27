#!/bin/sh
set -euf

exec \
xclip -o | espeak -z &> /dev/null
