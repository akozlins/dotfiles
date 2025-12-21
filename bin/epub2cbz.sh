#!/bin/bash
set -eu

filename="${1##*/}"
filename="${filename%.*}"
DOUT="${2:-.cache/$filename/}"

mkdir -p .cache
trap 'rm -rf .cache/p-*.jpg .cache/v???' EXIT HUP INT TERM

MARGIN=8

podman run -it --rm \
    --userns=keep-id --volume "$PWD:$PWD" --workdir "$PWD" \
    --entrypoint= \
    linuxserver/calibre \
    ebook-convert "$1" .cache/p.pdf \
    --pdf-page-margin-bottom $MARGIN --pdf-page-margin-left $MARGIN  --pdf-page-margin-right $MARGIN --pdf-page-margin-top $MARGIN

#pdfjam --trim "20mm 20mm 20mm 20mm" .cache/p.pdf --outfile .cache/p1.pdf

nPages=$(pdftk .cache/p.pdf dump_data | awk '/NumberOfPages/{print $2}')
nChunks=$((($nPages+99)/100))

( cd .cache
    pdftocairo -jpeg -r 200 ./p.pdf p
    find . -name 'p-*.jpg' | sort | split --number=l/$nChunks --numeric-suffixes=1 --suffix-length=3 - v
)

for v in $(cd .cache && find v???) ; do
    mkdir -p -- "${DOUT%/*}"
    ( cd .cache && zip -r - -@ ) < .cache/$v > "$DOUT$v.cbz"
done
