#!/bin/sh

# <https://doc.rust-lang.org/cargo/reference/environment-variables.html>

# location of where to place all generated artifacts, relative to the current working directory
#export CARGO_TARGET_DIR=".cache"
export CARGO_INSTALL_ROOT="$XDG_DATA_HOME/cargo"
PATH="$CARGO_INSTALL_ROOT/bin:$PATH"
