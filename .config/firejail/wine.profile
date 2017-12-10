
noblacklist ${HOME}/wine
noblacklist ${HOME}/downloads

include /etc/firejail/disable-common.inc

whitelist ${HOME}/wine
whitelist ${HOME}/downloads

caps.drop all
netfilter
nodvd
nogroups
nonewprivs
noroot
notv
seccomp
