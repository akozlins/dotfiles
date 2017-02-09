#

source ~/.dotfiles/envrc

export PATH=$DOTFILES/bin:$PATH

export HISTORY_IGNORE="(reboot|rm *|sudo rm *|reset|cd|cd ..|ls|make|git add *)"



export ZSH=$DOTFILES/oh-my-zsh
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump

# ZSH update
export ZSH_UPDATE=$ZSH/cache/.zsh-update
DISABLE_AUTO_UPDATE="true"

ZSH_THEME="gentoo"
plugins=(gitfast command-not-found)
#CASE_SENSITIVE="true"

source $ZSH/oh-my-zsh.sh

setopt no_hup

setopt no_auto_menu
setopt no_auto_remove_slash

setopt no_share_history
setopt hist_ignore_all_dups



for file in $DOTFILES/alias.d/* ; do
  [ -f $file ] && source $file
done



# QUARTUS
source $DOTFILES/bin/quartus.sh

# GEANT4
source $DOTFILES/bin/geant4.sh

# MU3E
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/MU3E/software/install/lib



bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "^d" kill-whole-line
bindkey "^i" expand-or-complete-prefix
