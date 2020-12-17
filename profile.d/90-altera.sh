#!/bin/sh

if [ -z "${ALTERAD_LICENSE_FILE:+x}" ] ; then
    export ALTERAD_LICENSE_FILE=
fi

QUARTUS_ROOTDIR_PARENT="/opt/intelFPGA/18.0"
export QUARTUS_ROOTDIR="$QUARTUS_ROOTDIR_PARENT/quartus"

export QUARTUS_64BIT=1

export PATH="$PATH:$QUARTUS_ROOTDIR/bin"

export QSYS_ROOTDIR="$QUARTUS_ROOTDIR/sopc_builder/bin"
export PATH="$PATH:$QSYS_ROOTDIR"

export SOPC_KIT_NIOS2="$QUARTUS_ROOTDIR_PARENT/nios2eds"
export PATH="$PATH:$SOPC_KIT_NIOS2/bin"
export PATH="$PATH:$SOPC_KIT_NIOS2/sdk2/bin"
export PATH="$PATH:$SOPC_KIT_NIOS2/bin/gnu/H-x86_64-pc-linux-gnu/bin"

export INTELFPGAOCLSDKROOT="$QUARTUS_ROOTDIR_PARENT/hld"

#export MODELSIM_INSTALLDIR="$QUARTUS_ROOTDIR_PARENT/modelsim_ase"
#export PATH="$PATH:$MODELSIM_INSTALLDIR/bin"

# Intel FPGA Download Cable II
# /etc/udev/rules.d/51-usbblaster.rules
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="0666"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="0666"
