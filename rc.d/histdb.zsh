#/bin/zsh

# https://github.com/larkery/zsh-histdb

MY_ZSH_HISTDB="$ZSH/custom/plugins/zsh-histdb"

# zsh-histdb
if [ -n "$ZSH_VERSION" ] && [ -e "$MY_ZSH_HISTDB" ] ; then
    HISTDB_FILE="$XDG_CACHE_HOME/.zsh_history.histdb.db"
    source "$MY_ZSH_HISTDB/sqlite-history.zsh"
    source "$MY_ZSH_HISTDB/histdb-interactive.zsh"
    autoload -Uz add-zsh-hook
fi

MY_ZSH_AUTOSUGGEST="$ZSH/custom/plugins/zsh-autosuggestions"

if [ -e "$MY_ZSH_AUTOSUGGEST" ] ; then
    source "$MY_ZSH_AUTOSUGGEST/zsh-autosuggestions.zsh"

    _zsh_autosuggest_strategy_histdb_top_here() {
        local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
        suggestion=$(_histdb_query "$query")
    }

    ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
fi
