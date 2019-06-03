#!/bin/sh

if [ -f "/usr/local/bin/geant4.sh" ] && cd "/usr/local/bin" ; then
    . "geant4.sh"
    cd - > /dev/null
fi
