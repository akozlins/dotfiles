
noblacklist ${HOME}/.config/firefox
noblacklist ~/.config/qBittorrent
noblacklist ~/.local/share/data/qBittorrent

include /etc/firejail/firefox.profile

whitelist ${HOME}/.config/firefox
whitelist ~/.config/qBittorrent
whitelist ~/.local/share/data/qBittorrent
