#!/bin/sh
set -euf

if [ "$(id -u)" -ne 0 ] ; then
    exec sudo "$0" "$@"
fi

#Google 8.8.8.8 8.8.4.4
#Quad9 9.9.9.9 149.112.112.112
#OpenDNS Home 208.67.222.222 208.67.220.220
#Cloudflare 1.1.1.1 1.0.0.1
#CleanBrowsing 185.228.168.9 185.228.169.9
#Verisign 64.6.64.6 64.6.65.6
#Alternate DNS 198.101.242.72 23.253.163.53
#AdGuard DNS 176.103.130.130 176.103.130.131

RESOLV=/etc/resolv.conf

backup () {
    while [ -e "$RESOLV.bak" ] ; do
        printf '\n'
        printf '\033[0;31m'
        echo "w - overwrite"
        echo "q - quit/cancel"
        echo "c - continue"
        printf '\033[0m'

        printf "Backup '$RESOLV.bak' exists. Command [w,q,c]: "
        read -r cmd

        case "$cmd" in
        [w]* ) break ;;
        [q]* ) return 1 ;;
        [c]* ) return 0 ;;
        esac
    done

    cp -v "$RESOLV" "$RESOLV.bak"
}

update () {
    chattr -i "$RESOLV"
    cat - > "$RESOLV"
    chattr +i "$RESOLV"
}

while true ; do
    printf '\n'
    printf '\033[0;31m%s\033[0m\n' "$RESOLV"
    cat "$RESOLV"
    if [ -e "$RESOLV.bak" ] ; then
        printf '\033[0;31m%s\033[0m\n' "$RESOLV.bak"
        cat "$RESOLV.bak"
    fi

    printf '\n'
    printf '\033[0;31m'
    echo "b - backup"
    echo "r - restore"
    echo "L - localhost (127.0.0.1)"
    echo "G - Google (8.8.8.8, 8.8.4.4)"
    echo "O - OpenDNS (208.67.222.222, 208.67.220.220)"
    echo "C - Cloudflare (1.1.1.1, 1.0.0.1)"
    echo "q - quit"
    printf '\033[0m'

    printf 'Command [p,b,r,L,G,O,C,q]: '
    read -r cmd

    case "$cmd" in
    [b]* )
        backup
        continue
        ;;
    [r]* )
        cat "$RESOLV.bak" | update
        rm -vf "$RESOLV.bak"
        continue
        ;;
    [L]* )
        backup || continue
        update << EOF
nameserver 127.0.0.1
EOF
        continue
        ;;
    [G]* )
        backup || continue
        update << EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
        continue
        ;;
    [O]* )
        backup || continue
        update << EOF
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF
        continue
        ;;
    [C]* )
        backup || continue
        update << EOF
nameserver 1.1.1.1
nameserver 1.0.0.1
EOF
        continue
        ;;
    [q]* )
        exit
        ;;
    esac

done
