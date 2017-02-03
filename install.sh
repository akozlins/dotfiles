#!/bin/sh
set -euf -o pipefail
cd $(dirname `readlink -f $0`)

set -x

DOTFILES=$(dirname `readlink -f $0`)

declare -a files=(
  emacs.d
  Xresources
  dmrc
  gmrunrc
  gv
  mime.types
  nanorc
  rootrc
  tmux.conf
  xinitrc
  xscreensaver
  xsession
  zshrc

  config/aspell
  config/conky
  config/far2l
  config/fbpanel
  config/firejail
  config/git
  config/htop
  config/openbox
  config/pulse/client.conf
  config/systemd
  config/yaourt
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

ln -sfv -T $DOTFILES/bin ~/bin

curl -LSso vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#ln -s ~/.local/share/applications/mimeapps.list ~/.config/mimeapps.list
