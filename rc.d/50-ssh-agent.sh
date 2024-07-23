#

if [ -z "$SSH_CONNECTION" ] ; then
    systemctl --user status ssh-agent.service &> /dev/null
    # check return code for 'unit is not active'
    if [[ $? != 3 ]] && systemctl --user start ssh-agent.service ; then
        alias ssh="SSH_AUTH_SOCK='$XDG_RUNTIME_DIR/ssh-agent.socket' ssh"
        #export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    fi
fi
