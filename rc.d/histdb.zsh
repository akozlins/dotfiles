#!/bin/zsh

# https://github.com/larkery/zsh-histdb

ZSH_HISTDB="$XDG_DATA_HOME/zsh-histdb"

# zsh-histdb
if [ -e "$ZSH_HISTDB" ] ; then
    HISTDB_FILE="$XDG_DATA_HOME/.zsh_history.histdb.db"
    source "$ZSH_HISTDB/sqlite-history.zsh"
    source "$ZSH_HISTDB/histdb-interactive.zsh"
    autoload -Uz add-zsh-hook
fi
