#!/bin/bash

TO_ADDR="hostmaster@example.com"

if [ "${PAM_TYPE}" != "open_session" ] ; then
    exit 0
fi

ips=(
    $(hostname -i)
    127.0.0.1
)
for ip in "${ips[@]}" ; do
    if [ "${PAM_RHOST}" == "$ip" ] ; then
        exit 0
    fi
done

cat << EOF | mail -s "pam: ssh login" "$TO_ADDR"
user: ${PAM_USER}
rhost: ${PAM_RHOST}
EOF

exit 0
