#/bin/sh
set -euf

exec \
cat << EOF
/	&/
/run/media/$USER	&M:
$HOME	&H:
EOF
