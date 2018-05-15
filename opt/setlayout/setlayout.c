
#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>

/* orientation of pager */
#define _NET_WM_ORIENTATION_HORZ 0
#define _NET_WM_ORIENTATION_VERT 1

/* starting corner for counting spaces */
#define _NET_WM_TOPLEFT     0
#define _NET_WM_TOPRIGHT    1
#define _NET_WM_BOTTOMRIGHT 2
#define _NET_WM_BOTTOMLEFT  3

int main(int argc, char* argv[]) {
    if (argc < 4) {
        printf(
            "Usage: %s <layout> <nh> <nv> <corner>\n"
            "  <layout>  0 is horizontal and 1 is vertical layout\n"
            "  <nh>      number of desks horizontally\n"
            "  <nv>      number of desks vertically\n"
            "  <corner>  starting corner (0 = topleft, 1 = topright, 2 = bottomright, 3 = bottomleft)\n"
          , argv[0]
        );
        return 1;
    }

    long data[4];
    data[0] = atol(argv[1]); //_NET_WM_ORIENTATION_HORZ;
    data[1] = atol(argv[2]);
    data[2] = atol(argv[3]);
    data[3] = atol(argv[4]); //_NET_WM_TOPLEFT;

    Display* display = XOpenDisplay(NULL);
    int screen = DefaultScreen(display);
    Window root = RootWindow(display, screen);

    Atom atom = XInternAtom(display, "_NET_DESKTOP_LAYOUT", False);
    XChangeProperty(display, root, atom,
                    XA_CARDINAL, 32, PropModeReplace, (unsigned char*)&data, 4);

    XFlush(display);
    XCloseDisplay(display);

    return 0;
}
