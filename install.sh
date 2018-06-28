#!/bin/bash
set -euf

DOTFILES=$(dirname -- "$(readlink -e -- "$0")")
echo "DOTFILES = '$DOTFILES'"
unset CDPATH
cd "$DOTFILES" || exit 1

files=(
    bin

    .emacs.d

    .bashrc
    .bash_profile
    .dmrc
    .eltclshrc
    .nanorc
    .rootrc
    .unison
    .wicd
    .xinitrc
    .xsession
    .zshrc

    .config/aspell
    .config/conky
    .config/easystroke
    .config/far2l
    .config/fbpanel
    .config/firefox
    .config/firejail
    .config/fontconfig
    .config/git
    .config/gtk-3.0
    .config/htop
    .config/intellij-idea
    .config/mc
    .config/micro
    .config/mplayer
    .config/npm
    .config/openbox
    .config/pacman
    .config/pulse/client.conf
    .config/pulse/default.pa
    .config/root
    .config/systemd
    .config/tmux
    .config/vim
    .config/vlc
    .config/yaourt

    .config/mimeapps.list
    .config/pavucontrol.ini
    .config/qxkb.cfg
    .config/user-dirs.dirs
)

mkdir -pv "$HOME/.cache/ipe"

for file in "${files[@]}" ; do
    src="$DOTFILES/$file"
    dst="$HOME/$file"

    if [ ! -e "$src" ] ; then
        echo "ERROR: source '$src' does not exist"
        exit 1
    fi

    if [ -e "$dst" ] && [ "$(readlink -e -- "$dst")" = "$(readlink -e -- "$src")" ] ; then
        echo "INFO: '$dst' OK"
        continue;
    fi

    if [ -e "$dst" ] ; then
        echo "WARN: destination '$dst' exists"
        read -r -p "Continue? [y/N] " yn
        echo # new line
        case "$yn"
            in [yY]) ;;
            *) exit 1 ;;
        esac
    fi

    dstdir=$(dirname "$dst")
    if [ -f "$dst" ] && [ ! -d "$dstdir" ] ; then
        mkdir -pv "$dstdir"
    fi
    ln -sv -T "$src" "$dst"
done

#ln -s ~/.local/share/applications/mimeapps.list ~/.config/mimeapps.list

[ -d "opt/oh-my-zsh" ] && make -C opt oh-my-zsh
