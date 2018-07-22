#!/bin/sh

GEANT4_SH="/usr/local/bin/geant4.sh"

if [ -f "$GEANT4_SH" ] ; then
    cd "$(dirname -- "$GEANT4_SH")" || exit 1
    . "$GEANT4_SH"
    cd - > /dev/null
fi
