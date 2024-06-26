#!/bin/bash

[[ $- == *i* ]] || return

export MY_BASHRC_DATE="$MY_BASHRC_DATE:$(date +%s.%3N)"

# shellcheck source=./.profile
source "$HOME/.profile"
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

#shellcheck source=./etc/bash.bashrc
source "$DOTFILES/etc/bash.bashrc"

bind -f "$DOTFILES/.inputrc"



export HISTFILE=$(readlink -f -- "$DOTFILES/.bash_history")
export HISTFILESIZE=65536
export HISTSIZE=4096
export HISTCONTROL="ignoreboth:erasedups"
export HISTIGNORE="poweroff:reboot:reset:rm *:sudo rm *"

#export PROMPT_COMMAND="history -a; history -n"

shopt -s cmdhist
shopt -s expand_aliases
shopt -s histappend



[ -d "$DOTFILES"/rc.d ] && for f in "$DOTFILES"/rc.d/?*.sh ; do
    [ -f "$f" ] && source "$f"
done
unset f
