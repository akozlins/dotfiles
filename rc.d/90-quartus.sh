#!/bin/sh

export ALTERAD_LICENSE_FILE=

ROOT=/usr/local/intelFPGA/17.1

export QUARTUS_ROOTDIR=$ROOT/quartus
export PATH=$PATH:$QUARTUS_ROOTDIR/bin
export PATH=$PATH:$QUARTUS_ROOTDIR/sopc_builder/bin

export SOPC_KIT_NIOS2=$ROOT/nios2eds
export PATH=$PATH:$SOPC_KIT_NIOS2/bin
export PATH=$PATH:$SOPC_KIT_NIOS2/sdk2/bin
export PATH=$PATH:$SOPC_KIT_NIOS2/bin/gnu/H-x86_64-pc-linux-gnu/bin

# Intel FPGA Download Cable II
# /etc/udev/rules.d/51-usbblaster.rules
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="0666"
#SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="0666"
