#!/bin/bash
set -euf

export LC_ALL=ja_JP.UTF-8

export WINEARCH=win32

WINE="/bin/firejail -- /bin/wine"

set -- far "$@"
source "$DOTFILES/bin/wine.sh"
