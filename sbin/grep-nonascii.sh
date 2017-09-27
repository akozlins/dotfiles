#!/bin/sh
set -euf

exec \
grep -P "[^\x00-\x7F]" "$@"
