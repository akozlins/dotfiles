#!/bin/sh
# \
exec tclsh "$0" "$@"

exec stty "raw" <@stdin

while 1 {
    puts "menu:"
    puts "  \[q\] exit"
    puts "Select entry ..."
    set c [ read stdin 1 ]
    puts "c = '$c'"
    if { [ string equal $c "q" ] } break
}

exec stty "-raw" <@stdin
