#!/bin/sh
set -eu

if [ $# -lt 2 ] ; then
    echo "usage: $0 <host> <repo>"
    exit 1
fi

HOST="$1"
REPO="$2"

if [ ! -d "$REPO" ] ; then
    echo "ERROR: '$REPO' not found'"
    exit 1
fi

while
    PORT=$(hexdump -n 2 -e '/2 "%u"' /dev/urandom)
    [ "$PORT" -lt 16384 ] || nc -z localhost "$PORT"
do continue ; done

borg --version

socat -d TCP4-LISTEN:"$PORT,bind=localhost" \
    "EXEC:borg serve --append-only --restrict-to-path $REPO" &

SOCAT_PID=$!

ssh "$HOST" -R "$PORT:localhost:$PORT" \
    BORG_RSH="'sh -c \"exec socat STDIO TCP4-CONNECT:localhost:$PORT\"'" \
borg init \
    -e none \
    "ssh://$HOST/$REPO"

ssh "$HOST" -O cancel -R "$PORT:localhost:$PORT" || true
kill "$SOCAT_PID" || true

sync
