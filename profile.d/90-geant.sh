#!/bin/sh

for MY_GEANT4_SH in "/usr/local/bin/geant4.sh" "$HOME/.local/bin/geant4.sh" ; do
    if [ -f "$MY_GEANT4_SH" ] && cd "$(dirname "$MY_GEANT4_SH")" ; then
        . "$MY_GEANT4_SH"
        cd - > /dev/null
        break
    fi
done
