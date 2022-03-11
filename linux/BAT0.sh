#!/bin/bash
set -euf

BAT0=$(acpi -i)

if ! diff -q "BAT0.out~" <(echo "$BAT0") ; then
    ~/.dotfiles/sbin/BAT-energy.sh 0 >> "BAT0.$(date +%Y).out"
    echo "$BAT0" > "BAT0.out~"
fi
