#!/bin/sh
set -euf

while
    PORT=$(hexdump -n 2 -e '/2 "%u"' /dev/urandom)
    [ "$PORT" -lt 16384 ] || nc -z localhost "$PORT"
do continue ; done
echo "PORT = $PORT"

RPORT=5900

X11VNC_CMD="x11vnc -nopw -display :0 -localhost -once -timeout 5 -cursor none -scale 2/3"

ssh -S none -f -L "$PORT:localhost:$RPORT" -o ExitOnForwardFailure=yes "$@" "$X11VNC_CMD"
nc -z localhost "$PORT"
sleep 2.5
vncviewer DotWhenNoCursor=1 localhost:"$PORT"

ssh "$@" -O cancel -L "$PORT:localhost:$RPORT"
