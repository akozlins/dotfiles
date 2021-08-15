
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

int main(int argc, const char* argv[]) {
    if (argc < 4) {
        printf(
            "Usage: %s ORIENTATION COLUMNS ROWS CORNER\n"
            "    <ORIENTATION>  0 = horizontal, 1 = vertical\n"
            "    <COLUMNS>      number of columns\n"
            "    <ROWS>         number of rows\n"
            "    <CORNER>       starting corner (0 = topleft, 1 = topright, 2 = bottomright, 3 = bottomleft)\n",
            argv[0]
        );
        return 1;
    }

    int32_t data[4];
    data[0] = atol(argv[1]); //_NET_WM_ORIENTATION_HORZ;
    data[1] = atol(argv[2]);
    data[2] = atol(argv[3]);
    data[3] = atol(argv[4]); //_NET_WM_TOPLEFT;

    Display* display = XOpenDisplay(NULL);
    int screen = DefaultScreen(display);
    Window root = RootWindow(display, screen);

    Atom property = XInternAtom(display, "_NET_DESKTOP_LAYOUT", False);
    XChangeProperty(
        display, root, property,
        XA_CARDINAL, 32, PropModeReplace, (unsigned char*)data, 4
    );

    XFlush(display);
    XCloseDisplay(display);

    return 0;
}
