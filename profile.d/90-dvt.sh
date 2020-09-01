#!/bin/bash

licenses=()
#while IFS= read -r -d $'\0' ; do
#    licenses+=("$REPLY")
#done < <(find $PRIVATE/.config/dvt -name "dvt_*.license" -print0)

DVT_LICENSE_FILE=""
if [ "${#licenses[@]}" -ge 1 ] ; then
    DVT_LICENSE_FILE="${licenses[-1]}"
fi
export DVT_LICENSE_FILE
