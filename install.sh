#!/bin/sh
set -euf -o pipefail
cd $(dirname `readlink -f $0`)

set -x

DOTFILES=$(dirname `readlink -f $0`)

declare -a files=(
  emacs.d
  dmrc
  gmrunrc
  nanorc
  rootrc
  tmux.conf
  unison
  xinitrc
  xsession
  zshrc

  config/aspell
  config/conky
  config/far2l
  config/fbpanel
  config/firefox
  config/firejail
  config/git
  config/gtk-3.0
  config/htop
  config/mc
  config/npm
  config/openbox
  config/pacman
  config/pulse/client.conf
  config/systemd
  config/vlc
  config/yaourt

  config/mimeapps.list
  config/pavucontrol.ini
  config/qxkb.cfg
  config/user-dirs.dirs
)

git submodule init
git submodule update

mkdir -p ~/.config/pulse
mkdir -p ~/.cache/ipe

for file in ${files[@]} ; do
  if [[ -f $file || -d $file ]] ; then
    ln -sfv -T $DOTFILES/$file ~/.$file
  fi
done

#ln -s ~/.local/share/applications/mimeapps.list ~/.config/mimeapps.list

curl -LSso vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
