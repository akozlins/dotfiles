#!/bin/sh
# \
exec tclsh "$0" "$@"

if { $::argc != 2 } {
    return
}

set this $argv0

set class [ lindex $::argv 0 ]
set key [ lindex $::argv 1 ]

set ids ""
catch { set ids [ exec xdotool search --class $class ] }

set id [ exec xdotool getactivewindow ]
if { [ lsearch $ids $id ] == -1 } {
    exec notify-send $this "send keystroke '$key' to window '$id'"
    exec xdotool key --window $id $key
} \
else {
    exec notify-send $this "block keystroke '$key'"
}
