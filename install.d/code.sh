#!/bin/bash

for f in \
    "code/User/settings.json" \
    "code/User/keybindings.json" \
    "code/User/tasks.json" \
    "code-server/User/settings.json" \
    "code-server/User/keybindings.json" \
    "code-server/User/tasks.json" \
; do
    [ -f "$XDG_DATA_HOME/$f" ] && continue
    mkdir -p -- "$(dirname -- "$XDG_DATA_HOME/$f")"
    ln -s -T "$XDG_CONFIG_HOME/$f" "$XDG_DATA_HOME/$f"
done
