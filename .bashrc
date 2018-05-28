#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

DOTFILES=$(dirname -- "$(readlink -e -- "$HOME/.bashrc")")
export DOTFILES
. "$DOTFILES/envrc"
export PATH="$DOTFILES/bin:$PATH"



export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=65536
export HISTIGNORE="reboot:reset:cd:cd ..:ls:make:pwd"
export HISTSIZE=4096

#export PROMPT_COMMAND='history -a; history -n'



source "$DOTFILES/etc/bash.bashrc"
[ -x "/bin/dircolors" ] && eval "$(/bin/dircolors -b "$DOTFILES/etc/DIR_COLORS")"

bind -f "$DOTFILES/.inputrc"



shopt -s cmdhist
shopt -s expand_aliases
shopt -s histappend



for f in $DOTFILES/rc.d/?* ; do
    [ -f "$f" ] && source "$f"
done
