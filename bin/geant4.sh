#!/bin/sh

if [[ -f /usr/local/bin/geant4.sh ]] ; then
  cd /usr/local/bin
  source /usr/local/bin/geant4.sh
  cd - > /dev/null
fi