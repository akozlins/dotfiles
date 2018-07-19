#!/bin/sh
set -euf

echo on | tee "/sys/bus/usb/devices/$1/power/control"
