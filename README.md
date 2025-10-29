# `dotfiles`

## Aim

Minimize number of `.` files in `$HOME` directory.

Current list of _allowed_ `.` files:

- `.cache/`, `.config/`, `.local/`
- `.ssh/`
- `.profile`
- `.bashrc`, `.zshrc`
- `.bash_history`, `.zsh_history`

TODO (to remove):

- `.xsession-errors`
- `.android` (adb)
- `.var`

## Install

```
git clone https://github.com/akozlins/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```

## Layout

- `.local`, `.cache` and `$DOTFILES` have same parent directory
- ...

## TODO
