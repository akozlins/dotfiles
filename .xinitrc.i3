#!/bin/sh

. "$HOME/.profile"

for f in "$DOTFILES"/.config/xinitrc.d/?*.sh ; do
    [ -f "$f" ] && . "$f"
done

exec i3
