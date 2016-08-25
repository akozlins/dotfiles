
export ZSH=~/.dotfiles/oh-my-zsh
export ZDOTDIR=~/.dotfiles

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
setopt hist_ignore_space
export HISTORY_IGNORE="(reboot|rm *|reset|cd|cd ..|ls|make|git add -p *)"



[[ -f $HOME/.alias ]] && source $HOME/.alias

export EDITOR='nano'
export LESSHISTFILE=/dev/null

#source /usr/local/bin/thisroot.sh
source ~/bin/geant4.sh

export PATH=~/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/root:~/MU3E/software/install/lib

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
