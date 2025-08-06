#/bin/bash
set -euf

menu() {
    rofi -dmenu << EOF
trans
sleep
usbguard-list-blocked-devices
EOF
}

confirm() {
    echo -e "yes\nno\n" | \
    rofi -dmenu -mesg "Are you sure?"
}

case "$(menu)" in
trans)
    rofi -e "$(xsel -b | trans -b)"
    ;;
sleep)
    [[ "$(confirm)" == "yes" ]] || exit
    dunstify ok
    ;;
usbguard*)
    rofi -e "$(lxsudo sh -c "usbguard list-devices --blocked 2>&1")"
    ;;
esac
