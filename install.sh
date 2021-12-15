#!/bin/bash
set -euf

DOTFILES=$(dirname -- "$(readlink -f -- "$0")")
echo "DOTFILES = '$DOTFILES'"
unset CDPATH
cd "$DOTFILES" || exit 1

targets=(
    bin

    .config
    .pki
    .var

    .bashrc .zshrc
    .profile

    .rootrc
)

for target in "${targets[@]}" ; do
    link="$HOME/$target"
    target="$DOTFILES/$target"

    if [ ! -e "$target" ] ; then
        >&2 echo "E [$0] target '$target' does not exist"
        exit 1
    fi

    if [ -L "$link" ] && [ "$(readlink -f -- "$link")" = "$(readlink -f -- "$target")" ] ; then
        rm -fv -- "$link"
    fi

    if [ -e "$link" ] ; then
        >&2 echo "W [$0] link '$link' exists"
        read -r -p "Overwrite? [y,n,q,?] " sel
        case "$sel" in
            y)
                rm -rfv -- "$link"
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
    if [ ! -d "$link_dir" ] ; then
        mkdir -pv -- "$link_dir"
    fi

    if command -v realpath &> /dev/null ; then
        target=$(realpath -s --relative-to="$link_dir" "$target")
        ln -snv --relative -T "$target" "$link"
    else
        ln -snv -T "$target" "$link"
    fi
done

mkdir -pv -- "$HOME/.local/share"

mkdir -pv -- "$HOME/downloads"
mkdir -pv -- "$HOME/.cache/ipe"

mkdir -pv -- "$(readlink -f -- ./.arduino15)"
mkdir -pv -- "$(readlink -f -- ./.var/app)"

# Media/MIME Types
"$DOTFILES/.config/applications/init.sh"

# ZSH
make -C opt oh-my-zsh
