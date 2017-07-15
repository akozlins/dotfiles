#!/bin/sh
set -euf -o pipefail

window=$(xdotool getwindowfocus)
pid=$(xprop -id $window | grep PID)

exec \
kill -9 $pid
