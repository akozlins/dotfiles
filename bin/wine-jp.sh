#!/bin/bash
set -euf

export LC_ALL=ja_JP.UTF-8

export WINEARCH=win32

WINE="firejail -- wine"

set -- far "$@"
source "$DOTFILES/bin/wine.sh"
