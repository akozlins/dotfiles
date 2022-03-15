#!/bin/sh
set -eu

for BAT in /sys/class/power_supply/BAT* ; do
    NAME=$(basename -- "$BAT")
    if [ -r "$BAT/energy_now" ] ; then
        now=$(cat "$BAT/energy_now")
        design=$(cat "$BAT/energy_full_design")
        printf "%d.%01d%% " $((100*now/design)) $((1000*now/design%10))
        break
    fi
    if [ -r "$BAT/charge_now" ] ; then
        now=$(cat "$BAT/charge_now")
        full=$(cat "$BAT/charge_full")
        design=$(cat "$BAT/charge_full_design")
        vnow=$(cat "$BAT/voltage_now")
        printf "%d.%01d%%/%d.%02dV " $((100*now/design)) $((1000*now/design%10)) $((vnow/1000000)) $((vnow/10000%100))
        break
    fi
done
