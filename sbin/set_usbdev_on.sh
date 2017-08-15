#!/bin/sh
set -euf

echo on | sudo tee "/sys/bus/usb/devices/$1/power/control"
