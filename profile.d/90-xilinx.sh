#!/bin/sh

if [ -z "${XILINXD_LICENSE_FILE:+x}" ] ; then
    export XILINXD_LICENSE_FILE=
fi

export VIVADO_ROOTDIR="/opt/xilinx/Vivado/2018.3"
