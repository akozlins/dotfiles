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

for MY_ROOTSYS in \
    "$HOME/.local/root.cern.ch" \
; do
    if [ -x "$MY_ROOTSYS/bin/root" ] ; then
        ROOTSYS="$MY_ROOTSYS"
#        export ROOTSYS
        PATH="$ROOTSYS/bin:$PATH"
    fi
done

unset -v MY_ROOTSYS
