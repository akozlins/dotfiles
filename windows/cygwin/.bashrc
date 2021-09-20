
alias ls='ls --color=auto'
#alias sshx='ssh -c arcfour,blowfish-cbc -YC'
alias ping='/cygdrive/c/Windows/System32/PING.EXE'
#alias h='history'

export PS1='[\u@\H \W]$ '

export PATH=/usr/X11R6/bin:/usr/bin:/bin

export HISTSIZE=4096
export HISTFILESIZE=4096
export HISTCONTROL=erasedups:ignoredups:ignorespace
export HISTIGNORE="pwd:ls:ls -l:bg:fg:env:bpeek.*:bkill.*"

export LANG=en_US.iso88591
export LC_ALL=en_US.iso88591

shopt -s histappend
#export PROMPT_COMMAND="history -n; history -a"

export MYUSR=/cygdrive/d/usr
export PATH=$MYUSR/bin:$PATH
export MANPATH=$MYUSR/share/man:$MANPATH
export LD_LIBRARY_PATH=$MYUSR/lib:$MYUSR/lib64:$LD_LIBRARY_PATH

#source $MYUSR/bin/thisroot.sh
export ROOTSYS=$MYUSR
alias root="root -l"

export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$MYUSR/include

alias my='cd $MYUSR;pwd'
