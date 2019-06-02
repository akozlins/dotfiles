#!/bin/sh

export TEST_XSESSION="$TEST_XSESSION:$(date --iso-8601=ns)"

. "$HOME/.profile"

xrdb -merge "$DOTFILES/.Xresources"

#if [ -f /usr/bin/nvidia-settings ] ; then
#    echo "load nvidia-settings-rc"
#    /usr/bin/nvidia-settings --load-config-only --config="$DOTFILES/nvidia-settings-rc"
#fi

# specifying openbox instead of openbox-session will prevent autostart in /etc/xdg/autostart
exec openbox-session
