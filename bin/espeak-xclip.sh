#!/bin/sh
set -euf

exec \
xclip -selection clipboard -o | espeak -z \
> /dev/null 2>&1
