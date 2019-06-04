#!/bin/sh

. "$HOME/.profile"

xrdb -merge "$DOTFILES/.Xresources"

#if [ -f /usr/bin/nvidia-settings ] ; then
#    echo "load nvidia-settings-rc"
#    /usr/bin/nvidia-settings --load-config-only --config=$DOTFILES/nvidia-settings-rc
#fi

# specifying openbox instead of openbox-session will prevent autostart in /etc/xdg/autostart
exec openbox-session
