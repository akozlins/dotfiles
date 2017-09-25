# Opera browser profile

whitelist ~/downloads
whitelist ~/test

# =============================
# '/etc/firejail/opera.profile'
# =============================

noblacklist ~/.cache/opera
noblacklist ~/.config/opera
noblacklist ~/.pki

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-devel.inc

mkdir ~/.cache/opera
whitelist ~/.cache/opera
mkdir ~/.config/opera
whitelist ~/.config/opera
mkdir ~/.pki
whitelist ~/.pki

include /etc/firejail/whitelist-common.inc

netfilter
nodvd
notv
