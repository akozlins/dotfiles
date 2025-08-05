#!/bin/zsh

[[ -o interactive ]] || return

export MY_ZSHRC_DATE="$MY_ZSHRC_DATE:$(date +%s.%3N)"

# shellcheck source=./.profile
source "$HOME/.profile"
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"



HISTFILE=$(readlink -f -- "$DOTFILES/.zsh_history")
SAVEHIST=8192
HISTSIZE=8192
HISTORY_IGNORE="(poweroff|reboot|reset|rm *|sudo rm *|git*reset*--hard*)"

ZLE_REMOVE_SUFFIX_CHARS=""
ZLE_SPACE_SUFFIX_CHARS=""



ZDOTDIR="$DOTFILES"
ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

fpath+=("$XDG_CONFIG_HOME/zsh-completions")



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

bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "^d" kill-whole-line
bindkey "^[[3~" delete-char



[ -d "$DOTFILES"/rc.d ] && for f in "$DOTFILES"/rc.d/?*.sh "$DOTFILES"/rc.d/?*.zsh ; do
    [ -f "$f" ] && source "$f"
done
unset f

# case-insensitive match only if no case-sensitive matches
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Za-z}'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_ALT_C_OPTS=--walker=dir
export FZF_CTRL_T_OPTS=--walker=dir,file,hidden
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--walker-skip=.git,node_modules,.jj,.gradle,build,cmake-build,quartus-build'
export FZF_COMPLETION_DIR_OPTS='--walker=dir'
export FZF_COMPLETION_PATH_OPTS='--walker=file,dir,hidden'

PROMPT='%(!.%B%F{red}.%B%F{green}%n)%f@%B%F{magenta}%m%f:%F{yellow}%(!.%1~.%~) %F{red}%(!.#.$)%k%b%f '
