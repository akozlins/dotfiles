#!/bin/bash
set -euf

DOTFILES=$(dirname -- "$(readlink -f -- "$0")")
echo "DOTFILES = '$DOTFILES'"
unset CDPATH
cd "$DOTFILES" || exit 1

links=(
    # base links
    .cache .local downloads
    # .config
    .config/Element
    .config/far2l/history
    .config/kicad
    .config/LatticeSemi
    .config/libreoffice
    .config/syncthing
    .config/tmux/plugins
    .config/tmux/resurrect
    .config/unity3d
    .config/vim/bundle
    # ...
    .altera.quartus
    .android
    .arduino15
    .epspdf
    .FreeCAD
    .java
    .mozilla/firefox/default
    .pki
    .renpy
    .steam
    .unison
    .var/app
    .vscode-oss
    .Xilinx
)

# make dirs for links
for link in "${links[@]}" ; do
    if [ ! -L "$link" ] ; then
        >&2 echo "E [$0] link '$link' does not exist"
        exit 1
    fi
    dir=$(readlink -m -- "$link")
    mkdir -pv -- "$dir"
done

targets=(
    bin

    .config
    .pki
    .var

    .bashrc .zshrc
    .profile

    .rootrc
)

# create links that point to targets
for target in "${targets[@]}" ; do
    link="$HOME/$target"
    target="$DOTFILES/$target"

    if [ ! -e "$target" ] ; then
        >&2 echo "E [$0] target '$target' does not exist"
        exit 1
    fi

    # delete existing link
    if [ -L "$link" ] && [ "$(readlink -f -- "$link")" = "$(readlink -f -- "$target")" ] ; then
        >&2 echo "I [$0] link '$link -> $(readlink -- "$link")' exists"
        while true ; do
            read -r -p "Overwrite? [y,n,q,?] " sel
            case "$sel" in
                y) rm -fv -- "$link" ; break ;;
                n) continue 2 ;;
                q) exit 1 ;;
                *) continue ;;
            esac
        done
    elif [ -e "$link" ] ; then
        >&2 echo "W [$0] file '$link' exists"
        while true ; do
            read -r -p "Overwrite? [y,n,q,?] " sel
            case "$sel" in
                y) rm -rfv -- "$link" ; break ;;
                n) continue 2 ;;
                q) exit 1 ;;
                *) continue ;;
            esac
        done
    fi

    # make destination directory
    link_dir=$(dirname -- "$link")
    if [ ! -d "$link_dir" ] ; then
        mkdir -pv -- "$link_dir"
    fi

    if command -v realpath &> /dev/null ; then
        # create relative link
        target=$(realpath --relative-to="$link_dir" "$target")
        ln -snv --relative -T "$target" "$link"
    else
        # create normal link
        ln -snv -T "$target" "$link"
    fi
done

# Media/MIME Types
"$DOTFILES/.config/applications/init.sh"

# ZSH
make -C "$DOTFILES/opt" oh-my-zsh
