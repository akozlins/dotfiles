#!/bin/sh
set -eu

for BAT in /sys/class/power_supply/BAT* ; do
    [ ! -e "$BAT" ] && echo "n/a" && exit 1
    energy_now=$(cat "$BAT/energy_now")
    energy_full=$(cat "$BAT/energy_full_design")
    echo "$((100*energy_now/energy_full))%"
done
