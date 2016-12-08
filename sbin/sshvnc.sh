#!/bin/sh
#set -v

while [ 1 ] ; do
  PORT="$RANDOM"
  if [ "$PORT" -lt 1024 ] ; then continue; fi;
  nc -z localhost "$PORT"
  if [ "$?" -eq 0 ] ; then continue; fi
  break
done
echo "PORT = $PORT"

set -eu -o pipefail

X11VNC_CMD="x11vnc -nopw -display :0 -localhost -once -timeout 5 -scale 2/3"

ssh -S none -f -L "$PORT":localhost:5900 -o ExitOnForwardFailure=yes "$@" "$X11VNC_CMD"
nc -z localhost "$PORT"
sleep 2.5; vncviewer localhost:"$PORT"

ssh "$@" -O cancel -L "$PORT":localhost:5900
