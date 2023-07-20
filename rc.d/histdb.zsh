#!/bin/zsh

# https://github.com/larkery/zsh-histdb

MY_ZSH_HISTDB="$ZSH/custom/plugins/zsh-histdb"

# zsh-histdb
if [ -e "$MY_ZSH_HISTDB" ] ; then
    HISTDB_FILE="$XDG_DATA_HOME/.zsh_history.histdb.db"
    source "$MY_ZSH_HISTDB/sqlite-history.zsh"
    source "$MY_ZSH_HISTDB/histdb-interactive.zsh"
    autoload -Uz add-zsh-hook
fi
