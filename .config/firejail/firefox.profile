# Firefox browser profile

include globals.local
include qbittorrent.local

noblacklist ~/.config/firefox
whitelist ~/.config/firefox

whitelist ~/develop/firefox

# ===============================
# '/etc/firejail/firefox.profile'
# ===============================

noblacklist ${HOME}/.cache/mozilla
mkdir ${HOME}/.cache/mozilla/firefox
whitelist ${HOME}/.cache/mozilla/firefox

nowhitelist ${HOME}/.mozilla
include ${CFG}/firefox-common.profile



read-write ~/.dotfiles/.config/firefox
