#!/bin/sh

for MY_GEANT4_SH in \
    "/usr/local/bin/geant4.sh" \
    "$HOME/.local/bin/geant4.sh" \
    "$HOME/.local/geant4.cern.ch/bin/geant4.sh" \
; do
    if [ -f "$MY_GEANT4_SH" ] && cd "$(dirname -- "$MY_GEANT4_SH")" ; then
        . "$(readlink -f -- "$MY_GEANT4_SH")"
        cd - > /dev/null
        break
    fi
done

unset -v MY_GEANT4_SH

if [ -x "$HOME/.local/root.cern.ch/bin/root" ] ; then
    ROOTSYS="$HOME/.local/root.cern.ch"
#    export ROOTSYS
    PATH="$ROOTSYS/bin:$PATH"
fi
