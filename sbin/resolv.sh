#!/bin/bash
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

VPN=openvpn-client@$(hostname)

backup () {
    while [ -e "$RESOLV.bak" ] ; do
        printf '\n'
        printf '\033[0;31m'
        echo "w - overwrite"
        echo "q - quit"
        printf '\033[0m'

        printf "Backup '%s' exists. Command [w,q]: " "$RESOLV.bak"
        read -r -n 1
        printf '\n'

        case "$REPLY" in
        [w]* ) break ;;
        [q]* ) return 0 ;;
        esac
    done

    cp -v "$RESOLV" "$RESOLV.bak"
}

update () {
    cat - > "$RESOLV.new"
    chattr -i "$RESOLV"
    mv -- "$RESOLV.new" "$RESOLV"
    chattr +i "$RESOLV"
}

wicd () {
    while true ; do
        printf '\n'
        printf '\033[0;31m'
        echo "    [s] scan"
        echo "    [l] list"
        echo "    [0-9] connect"
        echo "    [k] reload iwl drivers"
        echo "    [q] quit"
        printf '\033[0m'

        printf 'Command [s,l,k,q]: '
        read -r -n 1
        printf '\n'

        case "$REPLY" in
        [s]* )
            wicd-cli --wireless --scan
            wicd-cli --wireless -l
            continue
            ;;
        [l]* )
            wicd-cli --wireless -l
            continue
            ;;
        [0-9]* )
            wicd-cli --wireless --connect -n "$REPLY"
            continue
            ;;
        [k]* )
            rmmod iwldvm
            rmmod iwlwifi
            sleep 1
            modprobe iwlwifi
            modprobe iwldvm
            continue
            ;;
        [q]* ) return 0 ;;
        esac
    done
}

while true ; do
    if [ -e "$RESOLV.bak" ] ; then
        printf '\n'
        printf '\033[0;31m'
        printf 'BACKUP: %s\n' "$RESOLV.bak"
        printf '\033[0m'
        cat "$RESOLV.bak"
    fi
    printf '\n'
    printf '\033[0;31m'
    lsattr "$RESOLV"
    printf '\033[0m'
    cat "$RESOLV"

    printf '\n'
    printf '\033[0;31m'
    echo "i - toggle immutable attribute"
    echo "b - backup"
    echo "r - restore"
    echo "L - 127.0.0.1"
    echo "G - Google (8.8.8.8, 8.8.4.4)"
    echo "O - OpenDNS (208.67.222.222, 208.67.220.220)"
    echo "C - Cloudflare (1.1.1.1, 1.0.0.1)"
    echo "S - systemd-resolved"
    echo "q - quit"
    printf '\033[0m'

    printf 'Command [p,b,r,L,G,O,C,q]: '
    read -r -n 1
    printf '\n'

    case "$REPLY" in
    [i]* )
        # toogle immutable attribute
        if lsattr "$RESOLV" | cut -d' ' -f1 | grep -q i ; then
            chattr -i "$RESOLV"
        else
            chattr +i "$RESOLV"
        fi
        ;;
    [b]* )
        backup
        continue
        ;;
    [r]* )
        update < "$RESOLV.bak"
        rm -fv -- "$RESOLV.bak"
        continue
        ;;
    [L]* )
        backup || continue
        update << EOF
nameserver 127.0.0.1
option trust-ad
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
    [S]* )
#        chattr -i "$RESOLV"
        ln -rsf /run/systemd/resolve/stub-resolv.conf "$RESOLV"
        continue
        ;;
    [v]* )
        systemctl -q is-active "$VPN" && systemctl stop "$VPN"
        ping -c 1 hz11 && systemctl start "$VPN"
        continue;
        ;;
    [w]* )
        wicd
        continue
        ;;
    [q]* )
        exit
        ;;
    esac

done
