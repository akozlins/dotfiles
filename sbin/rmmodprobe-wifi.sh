#!/bin/sh
set -euf

# reload wifi modules

rmmod iwldvm iwlwifi
sleep 1
modprobe iwldvm iwlwifi
