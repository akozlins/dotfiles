#!/bin/bash

[[ $- == *i* ]] || return

. "$HOME/.profile"



source "$DOTFILES/etc/bash.bashrc"

bind -f "$DOTFILES/.inputrc"



export HISTFILE="$XDG_DATA_HOME/.bash_history"
export HISTFILESIZE=65536
export HISTSIZE=4096
export HISTCONTROL="ignoreboth:erasedups"
export HISTIGNORE="reboot:reset:rm *:sudo rm *:mv *:sudo mv *:cp *:sudo cp *:ls *:la *"

#export PROMPT_COMMAND="history -a; history -n"

shopt -s cmdhist
shopt -s expand_aliases
shopt -s histappend



for f in "$DOTFILES"/rc.d/?* ; do
    [ -f "$f" ] && . "$f"
done
