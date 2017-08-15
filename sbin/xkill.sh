#!/bin/sh
set -euf

window=$(xdotool getwindowfocus)
pid=$(xprop -id "$window" | grep PID)

exec \
kill -9 "$pid"
