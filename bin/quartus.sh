#!/bin/sh

export LM_LICENSE_FILE=

ROOT=/usr/local/intelFPGA/16.1

export QUARTUS_ROOTDIR=$ROOT/quartus
export PATH=$PATH:$QUARTUS_ROOTDIR/bin
export PATH=$PATH:$QUARTUS_ROOTDIR/sopc_builder/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:$QUARTUS_ROOTDIR/linux64

#export QSYS_ROOTDIR=$QUARTUS_ROOTDIR/sopc_builder/bin

export SOPC_KIT_NIOS2=$ROOT/nios2eds
export PATH=$PATH:$SOPC_KIT_NIOS2/bin
export PATH=$PATH:$SOPC_KIT_NIOS2/sdk2/bin
export PATH=$PATH:$SOPC_KIT_NIOS2/bin/gnu/H-x86_64-pc-linux-gnu/bin
