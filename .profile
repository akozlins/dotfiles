#!/bin/sh

export MY_PROFILE_DATE="${MY_PROFILE_DATE:+$MY_PROFILE_DATE:}$(date +%s.%3N)"

DOTFILES=$(dirname -- "$(readlink -f -- "$HOME/.profile")")
export DOTFILES



#export HOME="${HOME:-$(getent passwd $(id --user) | cut -d: -f6)}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
if [ ! -e "$XDG_CACHE_HOME" ] ; then
    mkdir -p -- "$XDG_CACHE_HOME"
fi
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
#export XDG_RUNTIME_DIR="/run/user/$(id --user)"

export MEDIA="/run/media/$USER"



#export LANG="en_US.UTF-8"

export EDITOR="nano -c"
export BROWSER="firefox"

# display first page if several man pages are available
export MAN_POSIXLY_CORRECT=1

# WINE
export WINEPREFIX="$XDG_DATA_HOME/wine/default"
export WINEDLLOVERRIDES="winemenubuilder.exe=d"
#export WINEDLLOVERRIDES="winemenubuilder.exe=d;winedevice.exe=d"

# Delay initialization of the ATK Bridge
# https://wiki.gnome.org/Accessibility/Documentation/GNOME2/Mechanics
# * remove warning "Couldn't connect to accessibility bus: ..."
export NO_AT_BRIDGE=1

# High DPI Support in Qt
# http://doc.qt.io/qt-5/highdpi.html
# * disable automatic scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=0

#export XUSERFILESEARCHPATH=



# android
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export ANDROID_HOME="$ANDROID_USER_HOME/sdk"
[ -e "$ANDROID_HOME" ] || mkdir -p -- "$ANDROID_HOME"

export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"

# go
export GOPATH="$XDG_DATA_HOME/go"

export ASPELL_CONF="home-dir $XDG_CONFIG_HOME/aspell;"
export ATOM_HOME="$XDG_CONFIG_HOME/atom"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
export FREECAD_USER_HOME="$DOTFILES"
export GMVAULT_DIR="$XDG_CONFIG_HOME/gmvault"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export INPUTRC="$DOTFILES/.inputrc"
export IPELATEXDIR="$XDG_CACHE_HOME/ipe/latexrun"
export IPELETPATH="$XDG_CONFIG_HOME/ipe/ipelets"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export KDEHOME="$XDG_CONFIG_HOME/kde4"
export LEDGER_FILE="$XDG_CONFIG_HOME/hledger/journal"
export LESSHISTFILE=-
export MATHEMATICA_USERBASE="$XDG_CONFIG_HOME/Mathematica"
export MINISIGN_CONFIG_DIR="$XDG_CONFIG_HOME/minisign"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export MYSQL_HISTFILE="$XDG_CACHE_HOME/.mysql_history"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/.node_repl_history"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/config"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export OPERA_PERSONALDIR="$XDG_CONFIG_HOME/opera"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/password-store"
export PROXYCHAINS_CONF_FILE="$XDG_CONFIG_HOME/proxychains.conf"
export PSQL_HISTORY="$XDG_CACHE_HOME/.psql_history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python/pycache"
export SQLITE_HISTORY="$XDG_CACHE_HOME/.sqlite_history"
export STACK_ROOT="$XDG_CACHE_HOME/stack"
export STEAM_HOME="$XDG_DATA_HOME/steam"
#export UNISON="$XDG_CONFIG_HOME/unison"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export WGETRC="$DOTFILES/.wgetrc"
export XINITRC="$DOTFILES/.xinitrc"

export RANDFILE="$XDG_CONFIG_HOME/.rnd"

#export XAUTHORITY="${XAUTHORITY:-$XDG_CACHE_HOME/.Xauthority}"

# nvidia
[ -e "$XDG_CACHE_HOME/.nv" ] || mkdir -p -- "$XDG_CACHE_HOME/.nv"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/.nv"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/.nv"

for f in "$DOTFILES"/profile.d/?*.sh ; do
    [ -f "$f" ] && . "$f"
done
unset f

# remove duplicates from PATH
PATH="$DOTFILES/bin:$HOME/.local/bin:$PATH"
if command -v awk 2>&1 > /dev/null ; then
    PATH=$(printf %s "$PATH" | awk -v RS=: '!a[$0]++ { if(n++) printf(":"); printf("%s", $0) }')
fi
export PATH
