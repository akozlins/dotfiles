#!/usr/bin/env python3

import argparse
import json
import pathlib
import sys

import yaml

parser = argparse.ArgumentParser()
parser.add_argument("fin", nargs="?", default="-")
args = parser.parse_args()

if args.fin == "-" :
    fin = sys.stdin
else :
    fin = pathlib.Path(args.fin).open(mode="r", encoding = "utf-8")

fout = sys.stdout

yaml.dump(json.load(fin), fout,
    sort_keys=False,
    encoding=("utf-8"),
    allow_unicode=True,
)
