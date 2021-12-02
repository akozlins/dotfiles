#!/bin/sh

. "$HOME/.profile"

for f in "$DOTFILES"/.config/xinitrc.d/?*.sh ; do
    [ -f "$f" ] && . "$f"
done

# specifying openbox instead of openbox-session will prevent autostart in /etc/xdg/autostart
exec openbox-session
