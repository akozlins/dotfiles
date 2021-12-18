#

# <https://ipython.org/ipython-doc/3/config/options/index.html>

import os

c = get_config()

c.TerminalIPythonApp.display_banner = True
c.TerminalInteractiveShell.confirm_exit = False

HIST_DIR = os.environ['HOME'] + "/.cache/ipython/profile_default";
os.makedirs(HIST_DIR, exist_ok = True)
c.HistoryManager.hist_file = HIST_DIR + "/history.sqlite"
