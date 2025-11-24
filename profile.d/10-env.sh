#!/bin/sh

# <https://www.freedesktop.org/software/systemd/man/environment.d.html>
my_load_conf () {
    while IFS='' read -r line ; do
        case "$line" in
        # Empty lines and lines beginning with the comment character "#" are ignored.
        ''|'#'*)
            ;;
        '='*)
            >&2 echo "E [$0] empty variable name: '$line'"
            ;;
        # Each KEY must be a valid variable name.
        [!A-Z_a-z]*=*|*[!0-9A-Z_a-z]*=*)
            >&2 echo "E [$0] invalid varible name '$line'"
            ;;
        # The configuration files contain a list of "KEY=VALUE" environment variable assignments.
        *=*)
            eval "export $line"
            ;;
        *)
            >&2 echo "E [$0] not a KEY=VALUE assignment '$line'"
            ;;
        esac
    done < "$1"
}

set -a # set export attribute for each variable assignment
if false && [ -d "$XDG_CONFIG_HOME/environment.d" ] ; then
    while IFS='' read -r conf ; do
        . "$conf"
    done < <(find "$XDG_CONFIG_HOME/environment.d/" -name '*.conf')
fi
set +a
