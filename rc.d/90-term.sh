#!/bin/sh

#export TERM=xterm-256color

if [ -z "$LS_COLORS" ] && [ -n "$(command -v dircolors)" ] && [ "$TERM" = "alacritty" ] ; then
    eval "$(env TERM=alacritty-color dircolors)"
fi
