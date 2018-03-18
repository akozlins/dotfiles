#!/bin/sh
set -euf

# reload wifi modules

rmmod iwldvm
rmmod iwlwifi
sleep 1
modprobe iwlwifi
modprobe iwldvm
