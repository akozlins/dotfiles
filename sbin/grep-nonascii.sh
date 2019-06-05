#!/bin/sh
set -euf

exec \
grep --line-number -P "[^\\x00-\\x7F]" "$@"
