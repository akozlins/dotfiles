
SetNumLockState, AlwaysOff

+SC051::
{
Send +{PgDn}
return
}

+SC049::
{
Send +{PgUp}
return
}

SC049::SC149
SC051::SC151
SC052::SC152

#!f::Run C:\Program Files\Far\Far.exe D: C:\
#!b::Run C:\CygWin\bin\run.exe -p /usr/X11R6/bin rxvt -geometry 120x30+0+0 -sr -sl 10000 -fg white -bg black -fn "-adobe-courier-medium-r-*-*-16-*-*-*-*-*-*-*" -fb "-adobe-courier-medium-r-*-*-16-*-*-*-*-*-*-*" -tn cygwin -e /bin/bash
;#!b::Run C:\CygWin\bin\run.exe -p /usr/X11R6/bin xterm -geometry 120x30+0+0 -sl 10000 -fg white -bg black -fn "-*-fixed-medium-r-*-*-14-*-*-*-*-*-*-*" -fb "-*-fixed-medium-r-*-*-14-*-*-*-*-*-*-*" -tn cygwin -e /bin/bash

#!Down::
WinGet, state, MinMax, A
if(state == 0)
{
  WinMinimize, A
}
else
{
  WinRestore, A
}
return

#!Up::
WinGet, state, MinMax, A
if(state == 0)
{
;#IfWinActive ahk_class ConsoleWindowClass
  WinMaximize, A
}
else
{
  WinRestore, A
}
return
