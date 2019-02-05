# Opera browser profile

whitelist ~/downloads
whitelist ~/test

# =============================
# '/etc/firejail/opera.profile'
# =============================

noblacklist ${HOME}/.cache/opera
noblacklist ${HOME}/.config/opera

mkdir ${HOME}/.cache/opera
mkdir ${HOME}/.config/opera
whitelist ${HOME}/.cache/opera
whitelist ${HOME}/.config/opera

include /etc/firejail/chromium-common.profile
