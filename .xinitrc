#!/bin/sh

. ~/.dotfiles/envrc



userresources=$DOTFILES/.Xresources
usermodmap=$DOTFILES/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi



if [ -f /usr/bin/syndaemon ] ; then
    echo "start /usr/bin/syndaemon"
#    /usr/bin/syndaemon -t -k -i 1 -d &
fi

if [ -f /usr/bin/nvidia-settings ] ; then
    echo "load nvidia-settings-rc"
#    /usr/bin/nvidia-settings --load-config-only --config=$DOTFILES/nvidia-settings-rc
fi

# specifying openbox instead of openbox-session will prevent autostart in /etc/xdg/autostart
exec openbox-session
