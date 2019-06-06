# `dotfiles`

## Aim

Minimize number of `.` files in `$HOME` directory.

Current list of _allowed_ `.` files:

 - XDG : `.cache/`, `.config/` and `.local/`
 - `.ssh/`
 - `.pam_environment`
 - `.profile`
 - `.bashrc`
 - `.zshrc`
 - `.dmrc`
 - `.xsession`

TODO (to remove):

 - `.xsession-errors`
 - `.emacs.d` (use cmd opts, set $HOME)
 - `.android` (adb)
 - `.pki` (nssdb, use firejail)
 - `.wicd`
 - `.rootrc` (root.cern.ch)
 - `.eltclshrc`

## Install

```
git clone https://github.com/akozlins/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```
