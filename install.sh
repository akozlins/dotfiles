#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")"

set -x

DOTFILES="$(dirname -- "$(readlink -f -- "$0")")"

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
  .config/root
  .config/systemd
  .config/vlc
  .config/yaourt

  .config/mimeapps.list
  .config/pavucontrol.ini
  .config/qxkb.cfg
  .config/user-dirs.dirs
"

mkdir -p "$HOME/.config/pulse"
mkdir -p "$HOME/.cache/ipe"

for file in $files ; do
  if [ -f "$file" ] || [ -d "$file" ] ; then
    ln -sfv -T "$DOTFILES/$file" "$HOME/$file"
  fi
done

#ln -s ~/.local/share/applications/mimeapps.list ~/.config/mimeapps.list

# submodules

git submodule update --init --recursive
