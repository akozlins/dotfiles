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

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

bindkey "^d" kill-whole-line
bindkey "^[[3~" delete-char

# case-insensitive match only if no case-sensitive matches
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

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

source <(dircolors)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

if [ -f /usr/share/fzf/completion.zsh ] ; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
    FZF_COMPLETION_OPTS="--walker-skip=.git,node_modules,.jj,.gradle,build,cmake-build,quartus-build"
    FZF_COMPLETION_DIR_OPTS="--walker=dir"
    FZF_COMPLETION_PATH_OPTS="--walker=file,dir,hidden"
    FZF_COMPLETION_TRIGGER='**'
    FZF_ALT_C_OPTS="--walker=dir $FZF_COMPLETION_OPTS"
    FZF_CTRL_T_OPTS="--walker=dir,file,hidden $FZF_COMPLETION_OPTS"
fi

[ -d "$DOTFILES"/rc.d ] && for f in "$DOTFILES"/rc.d/?*.sh "$DOTFILES"/rc.d/?*.zsh ; do
    [ -f "$f" ] && source "$f"
done
unset f
