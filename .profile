#!/bin/sh

export MY_PROFILE_DATE="$MY_PROFILE_DATE:$(date +%s.%3N)"

DOTFILES=$(dirname -- "$(readlink -e -- "$HOME/.profile")")
export DOTFILES
export PATH="$DOTFILES/bin:$HOME/.local/bin:$PATH"



export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

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

# Java Usage Tracker
# https://docs.oracle.com/javacomponents/usage-tracker/overview/toc.htm
# * disable last usage time tracking
JAVA_USAGE_TRACKER=" \
-Dcom.oracle.usagetracker.config.file=$DOTFILES/.java/usagetracker.properties \
-Djdk.disableLastUsageTracking=true \
"
# Java Font Anti-Aliasing
# https://wiki.archlinux.org/index.php/java
# https://docs.oracle.com/javase/8/docs/technotes/guides/2d/flags.html
JAVA_FONT_AA=" \
-Dawt.useSystemAAFontSettings=on \
-Dswing.aatext=true \
"
# Java options
# https://docs.oracle.com/javase/8/docs/platform/jvmti/jvmti.html
export JAVA_TOOL_OPTIONS="$JAVA_USAGE_TRACKER $JAVA_FONT_AA"
# user home directory
export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Duser.home=$DOTFILES"

#export XUSERFILESEARCHPATH=



# android
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"

# go
export GOPATH="$XDG_DATA_HOME/go"

export ASPELL_CONF="home-dir $XDG_CONFIG_HOME/aspell;"
export ATOM_HOME="$XDG_CONFIG_HOME/atom"
export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"
export GMVAULT_DIR="$XDG_CONFIG_HOME/gmvault"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export INPUTRC="$DOTFILES/.inputrc"
export IPELATEXDIR="$XDG_CACHE_HOME/ipe/latexrun"
export IPELETPATH="$XDG_CONFIG_HOME/ipe/ipelets"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export KDEHOME="$XDG_CONFIG_HOME/kde4"
export LESSHISTFILE=-
export MATHEMATICA_USERBASE="$XDG_CONFIG_HOME/Mathematica"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export MYSQL_HISTFILE="$XDG_CACHE_HOME/.mysql_history"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/.node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export OPERA_PERSONALDIR="$XDG_CONFIG_HOME/opera"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export PROXYCHAINS_CONF_FILE="$XDG_CONFIG_HOME/proxychains.conf"
export PSQL_HISTORY="$XDG_CACHE_HOME/.psql_history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup"
export SQLITE_HISTORY="$XDG_CACHE_HOME/.sqlite_history"
export STACK_ROOT="$XDG_CACHE_HOME/stack"
#export UNISON="$XDG_CONFIG_HOME/unison"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export WGETRC="$DOTFILES/.wgetrc"
export XINITRC="$DOTFILES/.xinitrc"

export RANDFILE="$XDG_CONFIG_HOME/.rnd"

#export XAUTHORITY="$XDG_RUNTIME_DIR/.Xauthority"

# nvidia
[ -e "$XDG_CACHE_HOME/.nv" ] || mkdir -p "$XDG_CACHE_HOME/.nv"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/.nv"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/.nv"



for f in "$DOTFILES"/profile.d/?*.sh ; do
    [ -f "$f" ] && . "$f"
done
