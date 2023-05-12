#!/usr/bin/env python3

import argparse
import json
import pathlib
import sys

import lz4.block

parser = argparse.ArgumentParser()
parser.add_argument("-c", "--compress", action="store_true")
parser.add_argument("-d", "--decompress", action="store_true")
parser.add_argument("fin", nargs="?", default="-")
parser.add_argument("fout", nargs="?", default="-")
args = parser.parse_args()

args.fin = None if args.fin == "-" else pathlib.Path(args.fin)
args.fout = None if args.fout == "-" else pathlib.Path(args.fout)

MAGIC = b"mozLz40\x00"

if not ( args.compress ^ args.decompress ) :
    fin = sys.stdin.buffer if args.fin is None else args.fin.open(mode="rb")
    if ( fin.read(len(MAGIC)) == MAGIC ) :
        args.decompress = True
    else :
        args.compress = True
    fin.close()

if args.decompress :
    # read binary
    fin = sys.stdin.buffer if args.fin is None else args.fin.open(mode="rb")
    # write utf-8
    fout = sys.stdout if args.fout is None else args.fout.open(mode="w")

if args.compress :
    # read utf-8
    fin = sys.stdin if args.fin is None else args.fin.open(mode="r", encoding = "utf-8")
    # write binary
    fout = sys.stdout.buffer if args.fout is None else args.fout.open(mode="wb")

if args.decompress :
    if ( fin.read(len(MAGIC)) != MAGIC ) :
        msg = "invalid MAGIC"
        raise Exception(msg)
    j = json.loads(lz4.block.decompress(fin.read()))
    json.dump(j, fout)

if args.compress :
    j = json.load(fin)
    fout.write(MAGIC)
    fout.write(lz4.block.compress(bytes(json.dumps(j), "utf-8")))
