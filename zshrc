
export ZSH=~/.dotfiles/oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump
export ZSH_UPDATE=$ZSH/cache/.zsh-update

ZSH_THEME="gentoo"

#CASE_SENSITIVE="true"

#DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=7

HIST_STAMPS="yyyy-mm-dd"

plugins=(gitfast)

export PATH="/usr/local/bin:/usr/bin:/opt/cuda/bin:/usr/lib/jvm/default/bin"
#export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

source $ZSH/lib/history.zsh
setopt no_share_history
setopt hist_ignore_all_dups
export HISTORY_IGNORE="(reboot|rm *|sudo rm *|reset|cd|cd ..|ls|make|git add *)"




[[ -f $HOME/.dotfiles/alias ]] && source $HOME/.dotfiles/alias

export EDITOR='nano'
export LESSHISTFILE=/dev/null

export PATH=~/bin:$PATH

source ~/bin/geant4.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/MU3E/software/install/lib

export WINEDLLOVERRIDES="winemenubuilder.exe=d"



bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "^d" kill-whole-line

bindkey "^i" expand-or-complete-prefix



setopt NO_HUP



setopt no_auto_menu
setopt no_auto_remove_slash



source /usr/share/doc/pkgfile/command-not-found.zsh



#export QT_SELECT=4
