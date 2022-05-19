#!/bin/sh

#export TERM=xterm-256color

if [ -z "$LS_COLORS" -a -n "$(command -v dircolors)" -a "$TERM" = "alacritty" ]; then
    eval $(env TERM=alacritty-color dircolors)
fi
