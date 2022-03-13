#!/bin/bash
set -eu

OUT=""

for BAT in /sys/class/power_supply/BAT* ; do
#    if [ -r "$BAT/uevent" ] ; then
#        uevent=$(cat "$BAT/uevent")
#        OUT=$(printf "%s\n%s\n" "$OUT" "$uevent")
#        continue
#    fi
    NAME=$(basename -- "$BAT")
    if [ -r "$BAT/energy_now" ] ; then
        energy_now=$(cat "$BAT/energy_now")
        energy_full=$(cat "$BAT/energy_full_design")
        OUT=$(printf "%s: %s\n%s\n" "$NAME" "energy_now/energy_full = $energy_now/$energy_full" "$OUT")
    fi
    if [ -r "$BAT/charge_now" ] ; then
        now=$(cat "$BAT/charge_now")
        full=$(cat "$BAT/charge_full")
        design=$(cat "$BAT/charge_full_design")
        OUT=$(printf "%s: %s\n%s\n" "$NAME" "charge_now/full/design = $now/$full/$design" "$OUT")
    fi
done

if [ -z "$OUT" ] ; then
    OUT=$(acpi -i)
fi

if ! diff -q "BAT.out~" <(echo "$OUT") ; then
    printf "%s\n%s\n" "$(date -u --iso-8601=seconds)" "$OUT" >> "BAT.$(date +%Y).out"
    echo "$OUT" > "BAT.out~"
fi
