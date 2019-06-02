
if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME = $HOME.'/.config'
endif

set runtimepath-=~/.vim
set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath-=~/.vim/after
set runtimepath+=$XDG_CONFIG_HOME/vim/after



if empty($XDG_CACHE_HOME)
    let $XDG_CACHE_HOME = $HOME.'/.cache'
endif

if !isdirectory($XDG_CACHE_HOME . "/vim/backup")
    call mkdir($XDG_CACHE_HOME . "/vim/backup", "p")
endif
if has("patch-8.1.0251")
    set backupdir=$XDG_CACHE_HOME/vim/backup//
endif
set writebackup
set nobackup
set backupcopy=auto

if !isdirectory($XDG_CACHE_HOME . "/vim/swap")
    call mkdir($XDG_CACHE_HOME . "/vim/swap", "p")
endif
set directory=$XDG_CACHE_HOME/vim/swap//
set swapfile

if !isdirectory($XDG_CACHE_HOME . "/vim/undo")
    call mkdir($XDG_CACHE_HOME . "/vim/undo", "p")
endif
set undodir=$XDG_CACHE_HOME/vim/undo//
set undofile

set viminfo+=n$XDG_CACHE_HOME/vim/viminfo