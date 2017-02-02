#!/bin/sh
set -euf -o pipefail
cd $(dirname `readlink -f $0`)

set -x

DOTFILES=`readlink -f $0`

declare -a files=(
  zshrc
  tmux.conf
  Xresources xinitrc xscreensaver xsession dmrc
  rootrc
  gv
  gmrunrc
  emacs.d nanorc
  mime.types
  config/fbpanel config/firejail config/openbox config/systemd
  config/pulse/client.conf
  config/htop
  config/pavucontrol.ini config/qxkb.cfg config/user-dirs.dirs
  config/far2l
  config/aspell
  config/yaourt
  config/conky
  config/git
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
