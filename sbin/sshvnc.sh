#!/bin/sh
set -eu -o pipefail

X11VNC_COMMAND="x11vnc -display :0 -localhost -scale 1/2 -once -timeout 30"

#vncviewer&
ssh -f -L 5900:localhost:5900 -o ControlMaster=no -o ExitOnForwardFailure=yes -n "$@" "$X11VNC_COMMAND"
