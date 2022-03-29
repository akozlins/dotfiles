#!/bin/env python3

import argparse

parser = argparse.ArgumentParser()
parser.add_argument("fin", nargs="?", default="-")
args = parser.parse_args()

import sys

if args.fin == "-" :
    fin = sys.stdin
else :
    fin = open(args.fin, "r", encoding = "utf-8")

fout = sys.stdout

import json, yaml

yaml.dump(json.load(fin), fout,
    sort_keys=False,
    encoding=("utf-8"),
    allow_unicode=True,
)
