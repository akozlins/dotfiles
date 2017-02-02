
source .dotfiles/envrc

export ZSH=$DOTFILES/oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump
export ZSH_UPDATE=$ZSH/cache/.zsh-update

ZSH_THEME="gentoo"
plugins=(gitfast)
DISABLE_AUTO_UPDATE="true"
UPDATE_ZSH_DAYS=7
#CASE_SENSITIVE="true"

source $ZSH/oh-my-zsh.sh

HIST_STAMPS="yyyy-mm-dd"

source $ZSH/lib/history.zsh

setopt no_share_history
setopt hist_ignore_all_dups
export HISTORY_IGNORE="(reboot|rm *|sudo rm *|reset|cd|cd ..|ls|make|git add *)"



[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

[[ -f $DOTFILES/alias ]] && source $DOTFILES/alias

export EDITOR=nano



export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/MU3E/software/install/lib



bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "^d" kill-whole-line
bindkey "^i" expand-or-complete-prefix



setopt no_hup

setopt no_auto_menu
setopt no_auto_remove_slash



#export QT_SELECT=4
