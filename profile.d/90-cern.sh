#!/bin/sh

# unset `G4*` envs
unset MY_GEANT4 $(env | awk -F= '/^G4/ { if(i++) printf(" "); printf("%s", $1) }')

for MY_GEANT4 in \
    "$HOME/.local/geant4.cern.ch" \
    "/opt/geant4" \
    "/usr/local" \
; do
    if [ -f "$MY_GEANT4/bin/geant4.sh" ] && cd -- "$MY_GEANT4/bin" ; then
        . ./geant4.sh
        cd - > /dev/null
        break
    fi
done

unset -v MY_GEANT4

for MY_ROOTSYS in \
    "$HOME/.local/root.cern.ch" \
    "/opt/root" \
    "/usr/local" \
; do
    if [ -x "$MY_ROOTSYS/bin/root" ] ; then
        ROOTSYS="$MY_ROOTSYS"
#        export ROOTSYS
        PATH="$ROOTSYS/bin:$PATH"
        break
    fi
done

unset -v MY_ROOTSYS
