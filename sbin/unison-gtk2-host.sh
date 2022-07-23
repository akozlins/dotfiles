#!/bin/bash
set -eu

export UNISON="$XDG_DATA_HOME/unison"

mkdir -p -- "$UNISON"
cd -- "$UNISON" || exit 1
for f in "$XDG_CONFIG_HOME/unison"/*.prf ; do
    ln -fsv -- "$f"
done

exec \
unison-gtk2 \
    "$HOME" "ssh://$1/$HOME" \
    -servercmd "$DOTFILES/unison" \
    -logfile "$UNISON/$1.log" \
    -source default.prf
