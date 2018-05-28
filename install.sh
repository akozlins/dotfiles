#!/bin/sh
set -euf

DOTFILES=$(dirname -- "$(readlink -e -- "$0")")
unset CDPATH
cd "$DOTFILES" || exit 1

files="
    bin

    .emacs.d

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
"

mkdir -p "$HOME/.cache/ipe"

for file in $files ; do
    if [ ! -e "$DOTFILES/$file" ] ; then
        # TODO: error
        echo "WARN: source '$DOTFILES/$file' does not exist"
        continue
    fi

    if [ -e "$HOME/$file" ] ; then
        # TODO: replace or continue
        echo "WARN: destination '$HOME/$file' already exists"
    fi

    if [ -f "$DOTFILES/$file" ] ; then
        mkdir -p "$(dirname "$HOME/$file")"
    fi
    ln -sfv -T "$DOTFILES/$file" "$HOME/$file"
done

#ln -s ~/.local/share/applications/mimeapps.list ~/.config/mimeapps.list

# submodules

git submodule update --init --recursive

make -C opt oh-my-zsh
