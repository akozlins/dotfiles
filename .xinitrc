#!/bin/sh

export MY_XINITRC_DATE="${MY_XINITRC_DATE:+$MY_XINITRC_DATE:}$(date +%s.%3N)"

. "$HOME/.profile"

for f in "$DOTFILES"/.config/xinitrc.d/?*.sh ; do
    [ -f "$f" ] && . "$f"
done

# openbox as default
MY_SESSION="${1:-openbox}"
echo "$@"

case "$MY_SESSION" in
i3|i3wm)
    exec i3
    ;;
openbox)
    # specifying openbox instead of openbox-session will prevent autostart in /etc/xdg/autostart
    exec openbox-session
    ;;
*)
    # unknown session, try to run it as command
    exec "$@"
    ;;
esac
