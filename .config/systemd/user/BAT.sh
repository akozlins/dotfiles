#!/bin/bash
set -eu

OUT=$(acpi -i)

for BAT in /sys/class/power_supply/BAT* ; do
#    if [ -r "$BAT/uevent" ] ; then
#        uevent=$(cat "$BAT/uevent")
#        OUT=$(printf "%s\n%s\n" "$OUT" "$uevent")
#        continue
#    fi
    if [ -r "$BAT/energy_now" ] ; then
        energy_now=$(cat "$BAT/energy_now")
        energy_full=$(cat "$BAT/energy_full_design")
        OUT=$(printf "%s\n%s\n" "$OUT" "energy_now/energy_full = $energy_now/$energy_full")
    fi
    if [ -r "$BAT/charge_now" ] ; then
        now=$(cat "$BAT/charge_now")
        full=$(cat "$BAT/charge_full")
        design=$(cat "$BAT/charge_full_design")
        OUT=$(printf "%s\n%s\n" "$OUT" "charge_now/full/design = $now/$full/$design")
    fi
done

if ! diff -q "BAT.out~" <(echo "$OUT") ; then
    printf "%s\n%s\n" "$(date -u --iso-8601=seconds)" "$OUT" >> "BAT.$(date +%Y).out"
    echo "$OUT" > "BAT.out~"
fi
