#!/bin/sh
set -euf

exec \
grep --line-number --color -P "[^\\x00-\\x7F]" "$@"
