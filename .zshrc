#!/bin/zsh

[[ -o interactive ]] || return

export MY_ZSHRC_DATE="$MY_ZSHRC_DATE:$(date +%s.%3N)"

. "$HOME/.profile"



#export HISTFILE="$HOME/.zsh_history"
export HISTORY_IGNORE="(reboot|reset|rm *|sudo rm *|mv *|sudo mv *|cp *|sudo cp *|la *|ls *)"

export ZLE_REMOVE_SUFFIX_CHARS=""
export ZLE_SPACE_SUFFIX_CHARS=""

export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"



export ZSH="$DOTFILES/opt/oh-my-zsh"

ZSH_THEME="gentoo"

DISABLE_AUTO_UPDATE="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    command-not-found
    dotenv
)

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
