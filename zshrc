#

source ~/.dotfiles/envrc
export PATH=$DOTFILES/bin:$PATH

export HISTORY_IGNORE="(reboot|rm *|sudo rm *|reset|cd|cd ..|ls|make|pwd|git add *)"



export ZSH=$DOTFILES/oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump

# ZSH update
export ZSH_UPDATE=$ZSH/cache/.zsh-update
DISABLE_AUTO_UPDATE="true"

ZSH_THEME="gentoo"
plugins=(gitfast command-not-found)
#CASE_SENSITIVE="true"

source $ZSH/oh-my-zsh.sh

# job control
setopt no_hup

# completion
setopt no_auto_menu
setopt no_auto_remove_slash
setopt no_menu_complete

# history
setopt hist_ignore_all_dups
setopt no_share_history



for file in $DOTFILES/conf.d/* ; do
  [ -f $file ] && source $file
done



bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "^d" kill-whole-line
bindkey "^i" expand-or-complete-prefix
