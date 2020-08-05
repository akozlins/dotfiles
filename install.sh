#!/bin/bash
set -euf

DOTFILES=$(dirname -- "$(readlink -f -- "$0")")
echo "DOTFILES = '$DOTFILES'"
unset CDPATH
cd "$DOTFILES" || exit 1

mkdir -pv "$HOME/downloads"

files=(
    bin

    .config

    .bashrc
    .pam_environment
    .profile
    .xprofile
    .zshrc
)

for file in "${files[@]}" ; do
    target="$DOTFILES/$file"
    link="$HOME/$file"

    if [ ! -e "$target" ] ; then
        echo "ERROR: target '$target' does not exist"
        exit 1
    fi

    if [ -e "$link" ] && [ "$(readlink -f -- "$link")" = "$(readlink -f -- "$target")" ] ; then
        echo "INFO: link '$link' is OK"
        continue;
    fi

    if [ -e "$link" ] ; then
        echo "WARN: link '$link' exists"
        read -r -p "Overwrite? [y,n,q,?] " sel
        case "$sel" in
            y)
                rm -rv "$link"
                ;;
            n)
                continue
                ;;
            q)
                exit 1
                ;;
            *)
                echo "TODO"
                exit 1
                ;;
        esac
    fi

    link_dir=$(dirname -- "$link")
    if [ -e "$target" ] && [ ! -d "$link_dir" ] ; then
        mkdir -pv "$link_dir"
    fi
    ln -snv -T "$target" "$link"
done

#ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list

[ -d "opt/oh-my-zsh" ] && make -C opt oh-my-zsh
