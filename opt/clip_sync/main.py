#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.12"
# dependencies = [ "PyGObject>=3.54.2" ]
# ///

# ruff: noqa: S101

import logging
import signal
import sys
import threading

import gi

gi.require_version("Gdk", "3.0")
gi.require_version("Gtk", "3.0")
gi.require_version('Wnck', '3.0')
from gi.repository import Gdk, Gtk, Wnck # noqa: E402

logging.basicConfig(
    format='%(levelname).1s %(asctime)s.%(msecs)03d [%(filename)s:%(lineno)d:%(funcName)s] %(message)s',
    datefmt='%Y-%m-%dT%H:%M:%S', # %(asctime)s.%(msecs)03d
    level=logging.INFO,
    stream=sys.stdout,
)
logger = logging.getLogger(__name__)

def get_window_name(xid) :
    screen = Wnck.Screen.get_default()
    screen.force_update()
    for win in screen.get_windows() :
        if win.get_xid() == xid : return win.get_name()
    return None

class Clip :
    def __init__(self) -> None:
        self.mutex = threading.RLock()

        self.primary_xid : int = 0
        self.primary_text: str = ""

        # mark updates by 'us'
        self.skip_primary: int = 0
        self.skip_clipboard: int = 0

        self.ids: [int] = []

        self.primary = Gtk.Clipboard.get(Gdk.SELECTION_PRIMARY)
        self.primary.connect('owner-change', self.on_primary)
        self.clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
        self.clipboard.connect('owner-change', self.on_clipboard)

    # monitor PRIMARY and update CLIPBOARD
    def on_primary(self, cb: Gtk.Clipboard, event: Gdk.EventOwnerChange) -> None :
      with self.mutex :
        if not event.owner :
            logger.warning("no owner")
            return
        xid = event.owner.get_xid()
        logger.info('xid = %d', xid)
        self.ids.append(xid)

        if self.skip_primary > 0 :
            logger.info('skip')
            self.skip_primary -= 1
            return

        text = self.primary.wait_for_text()
        if not text : return
        logger.debug('text = "%s"', text)
        logger.info("len(text) = %d", len(text))

        if xid != self.primary_xid :
            logger.debug('primary_text = "%s"', self.primary_text)
            logger.info("len(primary_text) = %d", len(self.primary_text))
            logger.info('clipboard.set(primary_text)')
            self.skip_clipboard += 1
            self.clipboard.set_text(self.primary_text, -1)

        self.primary_xid = xid
        self.primary_text = text

    # monitor CLIPBOARD and copy to PRIMARY
    def on_clipboard(self, cb: Gtk.Clipboard, event: Gdk.EventOwnerChange) -> None :
      with self.mutex :
        if not event.owner :
            logger.warning("no owner")
            return
        xid = event.owner.get_xid()
        logger.info('xid = %d', xid)
        self.ids.append(xid)

        if self.skip_clipboard > 0 :
            logger.info('skip')
            self.skip_clipboard -= 1
            return

        text = self.clipboard.wait_for_text()
        if not text : return
        logger.debug('text = "%s"', text)
        logger.info("len(text) = %d", len(text))

        if text != self.primary_text :
            logger.info('primary.set(text)')
            self.skip_primary += 1
            self.primary.set_text(text, -1)
            self.primary_xid = xid
            self.primary_text = text

sigint_handler0 = signal.getsignal(signal.SIGINT)
def sigint_handler() :
    signal.signal(signal.SIGINT, sigint_handler0)
    Gtk.main_quit()

def main() -> None :
    clip = Clip()

    signal.signal(signal.SIGINT, sigint_handler)
    Gtk.main()

    logger.info('ids: %s\n', set(clip.ids))

if __name__ == "__main__" : main()
