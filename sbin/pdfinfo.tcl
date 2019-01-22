#!/bin/sh
# \
exec tclsh "$0" "$@"

set input [ lindex $::argv 0 ]

foreach { - name value } [ regexp -all -inline -line -- {([^:]*):(.*)} [ exec pdfinfo $input ] ] {
    array set pdfinfo [ list [ string trim $name ] [ string trim $value ] ]
}

foreach { name } [ array names pdfinfo ] {
    puts "$name : $pdfinfo($name)"
}
