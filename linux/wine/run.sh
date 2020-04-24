#!/bin/sh
set -euf

exec \
"$1" "$(winepath -u "$2")"
