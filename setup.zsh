#!/bin/bash

export GDIR=/home/wjb31/MLSALT/MLSALT8/practicals/

### NEEDED FOR PRACTICAL 1:

export PATH=$PATH:$GDIR/practical-1/bin

### NEEDED FOR PRACTICAL 3:

setopt aliases

alias printstrings=/home/wjb31/src/hifst.mlsalt-cpu1.5Nov15/ucam-smt//bin//printstrings.O2

FST=/home/wjb31/src/openfst-1.2.5/INSTALL_DIR/
export JSCRIPTS=$GDIR/practical-3/software/scripts
export PATH=$JSCRIPTS:$GDIR/practical-3/software/fsmtools:$FST/bin:$GDIR/practical-3/software:$PATH
export LD_LIBRARY_PATH=/home/wjb31/src/openfst-1.2.5/INSTALL_DIR/lib/

#### OTHERS: 
# ulimit -v 2097152
ulimit -v 4194304

