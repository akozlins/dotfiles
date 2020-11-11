#!/bin/bash
set -euf

export LC_ALL=C

while
    PORT=$(hexdump -n 2 -e '/2 "%u"' /dev/urandom)
    [ "$PORT" -lt 16384 ] || nc -z localhost "$PORT"
do continue ; done
echo "PORT = $PORT"

RPORT=5900

ARGS=(-L "$PORT:localhost:$RPORT" "$@")
ssh -S none -f -o ExitOnForwardFailure=yes "${ARGS[@]}" -- sleep 10
cleanup() {
    rv=$?
    ssh -O cancel "${ARGS[@]}"
    exit $rv
}
trap cleanup EXIT

nc -z localhost "$PORT"
sleep 2.5
vncviewer DotWhenNoCursor=1 localhost:"$PORT"
