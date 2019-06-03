#!/bin/sh

if [ -z ${ALTERAD_LICENSE_FILE:+x} ] ; then
    export ALTERAD_LICENSE_FILE=
fi

export QUARTUS_ROOTDIR="/opt/altera/18.0/quartus"
[ -d "$QUARTUS_ROOTDIR" ] || return

if [ "$(uname -m)" = "x86_64" ] ; then
    QUARTUS_64BIT='1'
else
    QUARTUS_64BIT='0'
fi
export QUARTUS_64BIT

export PATH="$PATH:$QUARTUS_ROOTDIR/bin"
export PATH="$PATH:$QUARTUS_ROOTDIR/sopc_builder/bin"

export SOPC_KIT_NIOS2="$QUARTUS_ROOTDIR/../nios2eds"
export PATH="$PATH:$SOPC_KIT_NIOS2/bin"
export PATH="$PATH:$SOPC_KIT_NIOS2/sdk2/bin"
export PATH="$PATH:$SOPC_KIT_NIOS2/bin/gnu/H-x86_64-pc-linux-gnu/bin"

#export MODELSIM_INSTALLDIR="$QUARTUS_ROOTDIR/../modelsim_ase"
#export PATH="$PATH:$MODELSIM_INSTALLDIR/bin"

# Intel FPGA Download Cable II
# /etc/udev/rules.d/51-usbblaster.rules
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="0666"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="0666"
