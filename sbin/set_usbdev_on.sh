#!/bin/sh
set -euf -o pipefail

echo on | sudo tee /sys/bus/usb/devices/$1/power/control
