#!/bin/zsh

[[ -o interactive ]] || return

export MY_ZSHRC_DATE="$MY_ZSHRC_DATE:$(date +%s.%3N)"

# shellcheck source=./.profile
source "$HOME/.profile"
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"



HISTFILE=$(readlink -f -- "$DOTFILES/.zsh_history")
SAVEHIST=8192
HISTSIZE=8192
HISTORY_IGNORE="(poweroff|reboot|reset|rm *|sudo rm *|git*reset*--hard*|*far2l*)"

ZLE_REMOVE_SUFFIX_CHARS=""
ZLE_SPACE_SUFFIX_CHARS=""



# prompt: `user@host:~/path $ ` ~ `green@magenta:yellow $ `
PROMPT='%(!.%B%F{red}.%B%F{green}%n)%f@%B%F{magenta}%m%f:%F{yellow}%(!.%1~.%~) %F{red}%(!.#.$)%k%b%f '



fpath+=("$XDG_CONFIG_HOME/zsh-completions")

ZDOTDIR="$DOTFILES"
ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
autoload -U compinit && compinit



# directories
unsetopt auto_cd

# completion
setopt no_auto_menu
setopt no_auto_remove_slash
setopt no_menu_complete

# history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_lex_words
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt no_share_history

# job control
setopt no_hup

# zle
setopt no_beep



# ignore everything under and to the right of the cursor when completing
bindkey "^i" expand-or-complete-prefix

bindkey '\e[1~'     beginning-of-line   # console
bindkey '\e[H'      beginning-of-line   # xterm
bindkey '\e[4~'     end-of-line         # console
bindkey '\e[F'      end-of-line         # xterm
bindkey '\e[2~'     overwrite-mode      # console, xterm
bindkey '\e[3~'     delete-char         # console, xterm

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "^d" kill-whole-line

# case-insensitive match only if no case-sensitive matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/.zcompcache"

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# move up or down within the the buffer
# or search the history matching the the start of the current line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search

zstyle ":completion:*" sort false
zstyle ':completion:*' list-dirs-first true

source <(SHELL=${SHELL:-/bin/zsh} dircolors)
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

if command -v fzf &> /dev/null && [[ "$(fzf --version)" > "0.48" ]] ; then
    # save current bindkeys
    local bindkey_R="$(bindkey '^R' | cut -d' ' -f2-)"
    [ -n "$bindkey_R" ] || bindkey_R="history-incremental-search-backward"

    source <(fzf --zsh)
    FZF_COMPLETION_OPTS="--walker-skip=.git,node_modules,.jj,.gradle,build,cmake-build,quartus-build"
    FZF_COMPLETION_DIR_OPTS="--walker=dir"
    FZF_COMPLETION_PATH_OPTS="--walker=file,dir,hidden"
    FZF_COMPLETION_TRIGGER='**'
    FZF_ALT_C_OPTS="--walker=dir $FZF_COMPLETION_OPTS"
    FZF_CTRL_T_OPTS="--walker=dir,file,hidden $FZF_COMPLETION_OPTS"

    # restore prev bindkeys
    bindkey "^R" "$bindkey_R"
fi

[ -d "$DOTFILES"/rc.d ] && for f in "$DOTFILES"/rc.d/?*.sh "$DOTFILES"/rc.d/?*.zsh ; do
    [ -f "$f" ] && source "$f"
done
unset f
