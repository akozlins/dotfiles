#!/bin/bash
set -eu

OUT=""

for BAT in /sys/class/power_supply/BAT* ; do
#    if [ -r "$BAT/uevent" ] ; then
#        uevent=$(cat "$BAT/uevent")
#        OUT=$(printf "%s\n%s\n" "$OUT" "$uevent")
#        continue
#    fi
    status=$(cat "$BAT/status")
    NAME=$(basename -- "$BAT")
    if [ -r "$BAT/energy_now" ] ; then
        now=$(cat "$BAT/energy_now")
        full=$(cat "$BAT/energy_full")
        design=$(cat "$BAT/energy_full_design")
        OUT=$(printf "%s: %s, %s\n%s" "$NAME" "$status" "energy_now/full/design = $now/$full/$design" "$OUT")
    fi
    if [ -r "$BAT/charge_now" ] ; then
        now=$(cat "$BAT/charge_now")
        full=$(cat "$BAT/charge_full")
        design=$(cat "$BAT/charge_full_design")
        OUT=$(printf "%s: %s, %s\n%s" "$NAME" "$status" "charge_now/full/design = $now/$full/$design" "$OUT")
    fi
    [[ $((100*now/full)) -le 25 ]] && dunstify "BAT: $((100*now/full))%"
done

if [ -z "$OUT" ] ; then
    OUT=$(acpi -i)
fi

if ! diff -q "BAT.out~" <(echo "$OUT") ; then
    printf "%s %s\n%s\n" "$(date -u --iso-8601=seconds)" "$(date +%s)" "$OUT" >> "BAT.$(date +%Y).out"
    echo "$OUT" > "BAT.out~"
fi
