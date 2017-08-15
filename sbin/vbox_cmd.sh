#!/bin/sh
set -euf

vm=win7
user=
password=

exec \
VBoxManage \
guestcontrol "$vm" \
--username "$user" \
--password "$password" \
exec --image "cmd.exe" \
--wait-exit \
-- \
"/C start $1"
