#!/bin/bash
set -euf

export LC_ALL=C

while
    PORT=$(hexdump -n 2 -e '/2 "%u"' /dev/urandom)
    [ "$PORT" -lt 16384 ] || nc -z localhost "$PORT"
do continue ; done
echo "PORT = $PORT"

RPORT=5900

PASSWD=$(tr -dc a-zA-Z0-9 < /dev/urandom | head -c16)

X11VNC_CMD=(x11vnc
    -passwd "$PASSWD"
    -localhost -once -timeout 5
    -display :0
    -cursor none -scale 2/3
)

LFWD="$PORT:localhost:$RPORT"

ssh -S none -f -L "$LFWD" -o ExitOnForwardFailure=yes "$@" -- "$(printf '%q ' "${X11VNC_CMD[@]}")"
nc -z localhost "$PORT"
sleep 2.5
vncviewer DotWhenNoCursor=1 localhost:"$PORT" -passwd <(vncpasswd -f <<< "$PASSWD")

ssh -O cancel -L "$LFWD" "$@"
