#!/bin/sh
set -euf

window=$(xdotool getwindowfocus)
pid=$(xprop -id "$window" | grep PID)

exec \
/usr/bin/kill -s TERM --timeout 100 KILL -- "$pid"
