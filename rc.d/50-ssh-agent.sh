#

if [ -z "$SSH_CONNECTION" ] \
&& [ -n "$DBUS_SESSION_BUS_ADDRESS" ] \
&& [ -r /usr/bin/systemctl ] ; then
    /usr/bin/systemctl --user status ssh-agent.service &> /dev/null
    # check unit is active or try to start
    if [[ $? == 0 ]] || [[ $? == 3 ]] && systemctl --user start ssh-agent.service ; then
        alias ssh="SSH_AUTH_SOCK='$XDG_RUNTIME_DIR/ssh-agent.socket' ssh"
        #export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    fi
fi
