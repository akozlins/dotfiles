#!/bin/sh
set -euf -o pipefail

#echo 2000 | sudo tee /sys/class/backlight/intel_backlight/brightness
echo $1 | sudo tee /sys/class/leds/asus\:\:kbd_backlight/brightness
