# `dotfiles`

## Aim

Minimize number of `.` files in `$HOME` directory.

Current list of _allowed_ `.` files:

 - `.cache/`, `.config/`, `.local/`
 - `.ssh/`
 - `.pam_environment`
 - `.profile`, `.xprofile`
 - `.bashrc`, `.zshrc`

TODO (to remove):

 - `.Xauthority`
 - `.xsession-errors`
 - `.android` (adb)

## Install

```
git clone https://github.com/akozlins/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```
