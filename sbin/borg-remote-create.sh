#!/bin/bash
set -eu

if [ $# -lt 2 ] ; then
    echo "usage: $0 <host> <repo> [patterns]"
    exit 1
fi

HOST=$1
REPO=$2

if [ ! -d "$REPO" ] ; then
    echo "ERROR: '$REPO' not found"
    exit 1
fi

PATTERNS=()
if [ $# -ge 3 ] ; then
    if [ ! -f "$3" ] ; then
        echo "ERROR: '$3' not found"
        exit 1
    fi
    while IFS='' read -r line || [ -n "$line" ] ; do
        [ ! -z "$line" ] && PATTERNS=("${PATTERNS[@]}" "--pattern='$line'")
    done < "$3"
fi

PREFIX="$HOST"

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
borg create \
    --verbose \
    --list --filter AME \
    --stats \
    --exclude-if-present .borgexclude --keep-exclude-tags \
    "${PATTERNS[@]}" \
    "ssh://$HOST/$REPO::$PREFIX-{utcnow:%Y%m%dT%H%M%S}"

ssh "$HOST" -O cancel -R "$PORT:localhost:$PORT" || true
kill "$SOCAT_PID" || true

borg prune \
    --verbose \
    --list \
    --stats \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=6 \
    --prefix="$PREFIX-" \
    "$REPO"

sync
