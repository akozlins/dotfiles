#!/bin/sh
# next line is executed in 'sh' and is comment in 'tcl' \
exec tclsh "$0" "${1+@}"
