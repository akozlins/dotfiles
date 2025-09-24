#!/bin/bash
set -euf

export LC_ALL=C

SCALE=1/1
while [ $# -gt 0 ] ; do
    case "$1" in
    --scale)
        if [ $# -lt 2 ] ; then
            printf '%s\n' "ERROR: ..." >&2
            exit 1
        fi
        SCALE=$2
        shift
        ;;
    *)
        break
        ;;
    esac
    shift
done

while
    PORT=$(hexdump -n 2 -e '/2 "%u"' /dev/urandom)
    [ "$PORT" -lt 16384 ] || ss -tln "sport == :$PORT" | grep -q LISTEN
do continue ; done
echo "PORT = $PORT"

RPORT=5900

PASSWD=$(tr -dc a-zA-Z0-9 < /dev/urandom | head -c16)

X11VNC_CMD=(
    /usr/bin/x11vnc
    -listen 127.0.0.1 -rfbport "$RPORT"
    -passwd "$PASSWD"
    -once -timeout 15
    -display :0
    -noxdamage
    -cursor none
    -scale "$SCALE"
#    -auth "$HOME/.Xauthority"
)

ARGS=(-L "$PORT:127.0.0.1:$RPORT" "$@")
ssh -S none -f -o ExitOnForwardFailure=yes "${ARGS[@]}" -- "$(printf '%q ' "${X11VNC_CMD[@]}")"
cleanup() {
    rv=$?
    ssh -O cancel "${ARGS[@]}"
    exit $rv
}
trap cleanup EXIT

VNCVIEWER_CMD=(
    vncviewer
    "DotWhenNoCursor=1"
    #-Log "*:stdout:100"
    "127.0.0.1:$PORT"
)

ss -tln "sport == :$PORT" | grep -q LISTEN
sleep 2.5
VNC_PASSWORD="$PASSWD" "${VNCVIEWER_CMD[@]}"
