//

#include <gdk/gdkx.h>
#include <gtk/gtk.h>

#include <mutex>
#include <set>
#include <string>

#include <csignal>
#include <cstdio>

GtkClipboard *primary = nullptr;
GtkClipboard *clipboard = nullptr;

std::recursive_mutex rmutex;

Window primary_xid = 0;
std::string primary_text;

int skip_primary = 0;
int skip_clipboard = 0;

std::set<Window> ids;

void on_primary(GtkClipboard*, GdkEventOwnerChange* ev, gpointer) {
    std::lock_guard lguard(rmutex);

    if(!ev->owner) return;
    Window xid = GDK_WINDOW_XID(ev->owner);
    printf("I [on_primary] xid = %lu\n", xid);
    ids.insert(xid);

    if(skip_primary > 0) {
        printf("I [on_primary] skip\n");
        skip_primary -= 1;
        return;
    }

    gchar* text = gtk_clipboard_wait_for_text(primary);
    if(!text) return;

    if(xid != primary_xid) {
        printf("I [on_primary] clipboard.set(...)\n");
        skip_clipboard += 1;
        gtk_clipboard_set_text(clipboard, primary_text.c_str(), -1);
    }

    primary_xid = xid;
    primary_text = text;

    g_free(text);
}

void on_clipboard(GtkClipboard*, GdkEventOwnerChange* ev, gpointer) {
    std::lock_guard lguard(rmutex);

    if(!ev->owner) return;
    Window xid = GDK_WINDOW_XID(ev->owner);
    printf("I [on_clipboard] xid = %lu\n", xid);
    ids.insert(xid);

    if(skip_clipboard > 0) {
        printf("I [on_clipboard] skip\n");
        skip_clipboard -= 1;
        return;
    }

    gchar* text = gtk_clipboard_wait_for_text(clipboard);
    if(!text) return;

    if(text != primary_text) {
        printf("I [on_clipboard] primary.set(...)\n");
        skip_primary += 1;
        gtk_clipboard_set_text(primary, text, -1);
        primary_xid = xid;
        primary_text = text;
    }

    g_free(text);
}

int main(int argc, char** argv) {
    gtk_init(&argc, &argv);

    primary = gtk_clipboard_get(GDK_SELECTION_PRIMARY);
    if(!primary) return EXIT_FAILURE;
    clipboard = gtk_clipboard_get(GDK_SELECTION_CLIPBOARD);
    if(!clipboard) return EXIT_FAILURE;

    g_signal_connect(primary, "owner-change", G_CALLBACK(on_primary), nullptr);
    g_signal_connect(clipboard, "owner-change", G_CALLBACK(on_clipboard), nullptr);

    signal(SIGINT, [] (int) { gtk_main_quit(); });
    gtk_main();

    printf("I [main] ids:");
    for(auto& id : ids) printf(" %lu", id);
    printf("\n");

    return EXIT_SUCCESS;
}
