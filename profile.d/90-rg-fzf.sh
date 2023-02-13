#!/bin/sh

export RIPGREP_CONFIG_PATH="${RIPGREP_CONFIG_PATH:-$XDG_CONFIG_HOME/ripgrep/config}"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
