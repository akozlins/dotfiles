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
    esac
    shift
done

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
    -cursor none -scale "$SCALE"
#    -auth ~/.Xauthority
)

ARGS=(-L "$PORT:localhost:$RPORT" "$@")
ssh -S none -f -o ExitOnForwardFailure=yes "${ARGS[@]}" -- "$(printf '%q ' "${X11VNC_CMD[@]}")"
cleanup() {
    rv=$?
    ssh -O cancel "${ARGS[@]}"
    exit $rv
}
trap cleanup EXIT

nc -z localhost "$PORT"
sleep 2.5
vncviewer DotWhenNoCursor=1 localhost:"$PORT" -passwd <(vncpasswd -f <<< "$PASSWD")
