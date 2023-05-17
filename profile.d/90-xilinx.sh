#!/bin/sh

if [ -z "${XILINXD_LICENSE_FILE:+x}" ] ; then
    export XILINXD_LICENSE_FILE=
fi

export XILINX_VIVADO="/opt/xilinx/Vivado/2021.1"
