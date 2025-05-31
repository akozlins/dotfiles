#!/bin/sh
set -eu

if [ $# -lt 2 ] ; then
    echo "Usage:"
    echo "  $0 <host> <repo>"
    echo "  e.g. `$0 user@example.com $$BORG_REPO`"
    exit 1
fi

HOST="$1"
REPO="$2"

dir="$(dirname -- "$(readlink -f -- "$0")")"
"$dir/borg-remote.sh" "$HOST" "$REPO" \
    init \
    -e none \
    "ssh://$HOST/$REPO"

sync
