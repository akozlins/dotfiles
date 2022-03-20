#!/bin/bash
set -euf

TARGET=$(readlink -f -- "$1")
shift
[ -d "$TARGET" ] && TARGET="$TARGET/"

LOCK="$TARGET.inotifywait.lock"
[ -e "$LOCK" ] && exit 1

touch -- "$LOCK"
cleanup() {
    rv=$?
    rm -- "$LOCK"
    exit $rv
}
trap cleanup EXIT

while true ; do
    inotifywait -- "$TARGET"
    [ $# -ge 0 ] && "$@"
done
