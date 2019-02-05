# Firefox browser profile

noblacklist ~/.config/firefox
noblacklist ~/.config/qBittorrent
noblacklist ~/.local/share/data/qBittorrent

whitelist ~/.config/firefox
whitelist ~/.config/qBittorrent
whitelist ~/.local/share/data/qBittorrent

whitelist ~/downloads

# ===============================
# '/etc/firejail/firefox.profile'
# ===============================

noblacklist ${HOME}/.cache/mozilla

mkdir ${HOME}/.cache/mozilla/firefox
whitelist ${HOME}/.cache/mozilla/firefox

include /etc/firejail/firefox-common.profile



read-write ~/.dotfiles/.config/firefox
