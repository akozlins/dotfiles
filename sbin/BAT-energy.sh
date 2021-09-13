#!/bin/bash
set -euf

BAT="/sys/class/power_supply/BAT$1"
if [ ! -r "$BAT" ] ; then
    exit 1
fi

energy_now=$(cat "$BAT/energy_now")
energy_full=$(cat "$BAT/energy_full_design")

echo "$(date -u --iso-8601=seconds) $(acpi -i) $energy_now/$energy_full"
