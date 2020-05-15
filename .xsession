#!/bin/sh

. "$HOME/.xprofile"

# specifying openbox instead of openbox-session will prevent autostart in /etc/xdg/autostart
exec openbox-session
