# `dotfiles`

## Aim

Minimize number of `.` files in `$HOME` directory.

Current list of _allowed_ `.` files:

 - `.cache/`, `.config/`, `.local/`
 - `.ssh/`
 - `.pam_environment`
 - `.profile`
 - `.bashrc`, `.zshrc`
 - `.bash_history`, `.zsh_history`

TODO (to remove):

 - `.xsession-errors`
 - `.android` (adb)
 - `.rootrc`

## Install

```
git clone https://github.com/akozlins/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```
