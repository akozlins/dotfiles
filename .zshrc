#!/bin/zsh

[[ -o interactive ]] || return

. "$HOME/.profile"



export HISTFILE="$XDG_CACHE_HOME/.zsh_history"
export HISTORY_IGNORE="(reboot|reset|rm *|sudo rm *|mv *|sudo mv *|cp *|sudo cp *|ls *|la *)"
export ZLE_REMOVE_SUFFIX_CHARS=""
export ZLE_SPACE_SUFFIX_CHARS=""



export ZSH="$DOTFILES/opt/oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump"

# ZSH update
DISABLE_AUTO_UPDATE="true"

ZSH_THEME="gentoo"
plugins=(
    gitfast
    command-not-found
    dotenv
)
#CASE_SENSITIVE="true"

source "$ZSH/oh-my-zsh.sh"

# directories
unsetopt auto_cd

# completion
setopt no_auto_menu
setopt no_auto_remove_slash
setopt no_menu_complete

# history
setopt hist_ignore_all_dups
setopt hist_lex_words
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt no_share_history

# job control
setopt no_hup

# zle
setopt no_beep



bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "^d" kill-whole-line
bindkey "^i" expand-or-complete-prefix



for f in "$DOTFILES"/rc.d/?* ; do
    [ -f "$f" ] && . "$f"
done
