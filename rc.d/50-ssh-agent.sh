#

if [ -z "$SSH_CONNECTION" ] ; then
    systemctl --user start ssh-agent.service
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
