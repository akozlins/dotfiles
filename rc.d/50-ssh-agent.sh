#

if [ -z "$SSH_CONNECTION" ] ; then
    systemctl --user status ssh-agent.service &>/dev/null
    # check return code for 'unit is not active'
    [[ $? == 3 ]] && systemctl --user start ssh-agent.service \
    && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
