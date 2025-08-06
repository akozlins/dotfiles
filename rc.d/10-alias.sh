#!/bin/sh

alias man="LC_ALL=C man"

alias df='df -h'
alias du='du -h'

alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

alias ls='ls --color=auto --group-directories-first -h --file-type --time-style=long-iso'
alias la='ls -lAF'

alias reset='tput reset'

alias ag="ag --hidden"
alias fd="fd --hidden"
alias rg="rg --hidden"

alias grep-nonascii="grep --line-number --color --perl-regexp --regexp='[^\\x00-\\x7F]'"
alias rg-nonascii="rg --colors 'match:bg:red' --regexp '[^\\x00-\\x7F]'"
alias rg-ws='rg --colors "match:bg:red" "\\s+$"'

alias make='LC_ALL=C nice ionice make -j$(nproc --ignore=1)'
alias ninja='nice ionice ninja'

alias lg='lazygit'

# find how to write symbol via compose key
alias compose='fzf < /usr/share/X11/locale/en_US.UTF-8/Compose'
