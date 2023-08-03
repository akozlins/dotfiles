#/bin/bash
set -euf

pactl set-sink-volume @DEFAULT_SINK@ "$1"
dunstify --replace=0x73696e6b "sink volume:" $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5 }')
