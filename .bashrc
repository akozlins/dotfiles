#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$DOTFILES/etc/bash.bashrc"

bind -f "$DOTFILES/.inputrc"



export HISTCONTROL="ignoreboth:erasedups"
export HISTFILESIZE=65536
export HISTIGNORE="reboot:reset:rm *:sudo rm *:mv *:sudo mv *:cp *:sudo cp *:ls *:la *"
export HISTSIZE=4096

#export PROMPT_COMMAND="history -a; history -n"

shopt -s cmdhist
shopt -s expand_aliases
shopt -s histappend



for f in $DOTFILES/rc.d/?* ; do
    [ -f "$f" ] && source "$f"
done
