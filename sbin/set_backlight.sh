#!/bin/sh
set -euf

#echo 2000 | tee /sys/class/backlight/intel_backlight/brightness
echo "$1" | tee /sys/class/leds/asus::kbd_backlight/brightness
