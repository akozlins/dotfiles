#!/bin/sh
# \
exec tclsh "$0" "$@"

set input [ lindex $::argv 0 ]

proc pkginfo { pkg } {
    foreach { - name value } [ regexp -all -inline -line -- {([^:]*):(.*)} [ exec pacman -Qi $pkg ] ] {
        array set info [ list [ string trim $name ] [ string trim $value ] ]
    }
    return [ array get info ]
}

foreach { pkg - } [ exec pacman -Q ] {
    array unset info
    array set info [ pkginfo $pkg ]
    puts "$pkg => $info(Depends On)"
}
