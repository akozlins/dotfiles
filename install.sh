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
    .dmrc
    .eltclshrc
    .pam_environment
    .profile
    .rootrc
    .wicd
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
    .config/ipe
    .config/mc
    .config/micro
    .config/mplayer
    .config/nano
    .config/npm
    .config/openbox
    .config/pacman
    .config/parallel
    .config/pulse/client.conf
    .config/pulse/default.pa
    .config/root
    .config/systemd
    .config/tmux
    .config/unison
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
        read -r -p "Overwrite? [y,n,q,?] " sel
        case "$sel" in
            y)
                rm -v "$dst"
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

    dstdir=$(dirname -- "$dst")
    if [ -e "$src" ] && [ ! -d "$dstdir" ] ; then
        mkdir -pv "$dstdir"
    fi
    ln -sv -T "$src" "$dst"
done

#ln -s ~/.config/mimeapps.list ~/.local/share/applications/mimeapps.list

[ -d "opt/oh-my-zsh" ] && make -C opt oh-my-zsh
