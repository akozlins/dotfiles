#

# <https://ipython.org/ipython-doc/3/config/options/index.html>

import os
import pathlib

c = get_config() # noqa: F821 Undefined name `get_config`

c.TerminalIPythonApp.display_banner = True
c.TerminalInteractiveShell.confirm_exit = False

CACHE_HOME = pathlib.Path(os.getenv("XDG_CACHE_HOME", pathlib.Path("~/.cache").expanduser()))
HIST_DIR = CACHE_HOME.joinpath("ipython/profile_default")
HIST_DIR.mkdir(parents=True, exist_ok=True)
c.HistoryManager.hist_file = str(HIST_DIR.joinpath("history.sqlite"))
