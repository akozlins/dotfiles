#!/bin/bash
set -euf

DOTFILES=$(dirname -- "$(readlink -f -- "$0")")
echo "DOTFILES = '$DOTFILES'"
unset CDPATH
cd "$DOTFILES" || exit 1

dirs=(
    # base links
    .cache .local downloads
    # ...
    .altera.quartus
    .arduino15
    .cache/ipe
    .config/Element
    .config/far2l/history
    .config/LatticeSemi
    .config/tmux/plugins
    .config/tmux/resurrect
    .config/vim/bundle
    .epspdf
    .java
    .mozilla/firefox
    .pki
    .renpy
    .var/app
    .Xilinx
)

# make dirs for links
for dir in "${dirs[@]}" ; do
    dir=$(readlink -m -- "$dir")
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
        target=$(realpath -s --relative-to="$link_dir" "$target")
        ln -snv --relative -T "$target" "$link"
    else
        # create normal link
        ln -snv -T "$target" "$link"
    fi
done

# Media/MIME Types
"$DOTFILES/.config/applications/init.sh"

# ZSH
make -C opt oh-my-zsh
