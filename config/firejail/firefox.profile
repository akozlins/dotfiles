# Firefox browser profile

noblacklist ~/.config/firefox
noblacklist ~/.config/qBittorrent
noblacklist ~/.local/share/data/qBittorrent

whitelist ~/.config/firefox
whitelist ~/.config/qBittorrent
whitelist ~/.local/share/data/qBittorrent

whitelist ~/downloads
whitelist ~/test

# ===============================
# '/etc/firejail/firefox.profile'
# ===============================

noblacklist ~/.cache/mozilla
noblacklist ~/.pki

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-programs.inc

mkdir ~/.cache/mozilla/firefox
whitelist ~/.cache/mozilla/firefox
mkdir ~/.pki
whitelist ~/.pki

include /etc/firejail/whitelist-common.inc

caps.drop all
netfilter
nodvd
nogroups
nonewprivs
noroot
notv
protocol unix,inet,inet6,netlink
seccomp
shell none
tracelog

private-dev
private-tmp

noexec ${HOME}
noexec /tmp
