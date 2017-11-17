#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.dotfiles/envrc
export PATH=$DOTFILES/bin:$PATH



export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=65536
export HISTIGNORE="reboot:reset:cd:cd ..:ls:make:pwd"
export HISTSIZE=4096

#export PROMPT_COMMAND='history -a; history -n'



source $DOTFILES/etc/bash.bashrc
eval `dircolors -b "$DOTFILES/etc/DIR_COLORS"`

bind -f $DOTFILES/inputrc



# Mathematica fonts
#xset fp+ /usr/local/Wolfram/Mathematica/10.1/SystemFiles/Fonts/Type1

shopt -s cmdhist
shopt -s expand_aliases
shopt -s histappend



for file in $DOTFILES/rc.d/* ; do
  [ -f $file ] && source $file
done
