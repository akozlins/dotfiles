@echo off
SET DISPLAY=127.0.0.1:0.0

SET CYGWIN_ROOT=\cygwin
SET RUN=%CYGWIN_ROOT%\bin\run -p /usr/bin

SET PATH=.;%CYGWIN_ROOT%\bin;%PATH%

SET XAPPLRESDIR=
SET XCMSDB=
SET XKEYSYMDB=
SET XNLSPATH=


if not exist %CYGWIN_ROOT%\tmp\.X11-unix\X0 goto CLEANUP-FINISH
attrib -s %CYGWIN_ROOT%\tmp\.X11-unix\X0
del %CYGWIN_ROOT%\tmp\.X11-unix\X0

:CLEANUP-FINISH
if exist %CYGWIN_ROOT%\tmp\.X11-unix rmdir %CYGWIN_ROOT%\tmp\.X11-unix

%RUN% XWin -multiwindow -clipboard -silent-dup-error -nowinkill -notrayicon
