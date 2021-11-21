#!/bin/sh

alias man="LC_ALL=C man"

alias df='df -h'
alias du='du -h'

alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

alias ls='ls --color=auto --group-directories-first -h --file-type --time-style=long-iso'
alias la='ls -lAF'
alias make='LC_ALL=C make'

alias ag="ag --hidden"
alias fd="fd --hidden"
alias rg="rg --hidden"

alias grep-nonascii="grep --line-number --color --perl-regexp --regexp='[^\\x00-\\x7F]'"
alias rg-nonascii="rg --colors 'match:bg:red' --regexp '[^\\x00-\\x7F]'"
alias rg-tws="rg --colors 'match:bg:red' '\\s+$'"
