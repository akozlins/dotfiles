#

include globals.local
include qbittorrent.local

noblacklist ${HOME}/.config/firefox
whitelist ${HOME}/.config/firefox

whitelist ${HOME}/develop/firefox

# ===============================
# '/etc/firejail/firefox.profile'
# ===============================

noblacklist ${HOME}/.cache/mozilla
mkdir ${HOME}/.cache/mozilla/firefox
whitelist ${HOME}/.cache/mozilla/firefox

nowhitelist ${HOME}/.mozilla
include ${CFG}/firefox-common.profile



read-write ${HOME}/.dotfiles/.config/firefox
