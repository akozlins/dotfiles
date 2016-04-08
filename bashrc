#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f $HOME/.alias ]] && source $HOME/.alias

export EDITOR=nano

export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=65536
export HISTIGNORE="ls:cd:pwd:reset:reboot:* --help"
export HISTSIZE=4096

export LESSHISTFILE=/dev/null
#export PROMPT_COMMAND='history -a; history -n'
export MAKEFLAGS='-j'

#source /usr/local/bin/thisroot.sh
source /usr/local/bin/geant4.sh

export PATH=/usr/lib/colorgcc/bin:$PATH
export PATH=~/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/root:/home/akozlins/MU3E/software/install/lib

# remove gedit warning
export NO_AT_BRIDGE=1

#LANG="en_US.UTF-8"

# wine
export WINEDLLOVERRIDES="winemenubuilder.exe=d"
#export WINEDLLOVERRIDES="winemenubuilder.exe=d;winedevice.exe=d"

#export TERM=xterm-256color

#export PULSE_LATENCY_MSEC=60

# Mathematica fonts
#xset fp+ /usr/local/Wolfram/Mathematica/10.1/SystemFiles/Fonts/Type1

shopt -s cmdhist
shopt -s expand_aliases
shopt -s histappend
