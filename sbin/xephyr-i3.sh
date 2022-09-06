#!/bin/bash
set -euf

unset XDG_SEAT

MY_W=1000
MY_H=1000
if command -v xprop &> /dev/null ; then
    WORKAREA=($(xprop -root ' $0 $1 $2 $3' _NET_WORKAREA))
    MY_W=$(( (WORKAREA[3] - WORKAREA[1])*3/4 ))
    MY_H=$(( (WORKAREA[4] - WORKAREA[2])*3/4 ))
fi

MY_XEPHYR_OPTS=(
    # disable access control restrictions
    -ac
    # create root window with black background
    -br
    # don't reset after last client exists
    -noreset
    #  WIDTH[/WIDTHMM]xHEIGHT[/HEIGHTMM][+[-]XOFFSET][+[-]YOFFSET][@ROTATION][X][Y][xDEPTH/BPP[xFREQ]]
    -screen "${MY_W}x${MY_H}"
    "$@"
)

exec \
xinit "$DOTFILES/.xinitrc" i3 -- /usr/bin/Xephyr :1 "${MY_XEPHYR_OPTS[@]}" \
2>&1 | ts %FT%T > "$HOME/.cache/xephyr-i3.log" &
