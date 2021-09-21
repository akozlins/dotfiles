#!/bin/python

import argparse, sys;

parser = argparse.ArgumentParser();
parser.add_argument("-c", "--compress", action="store_true");
parser.add_argument("-d", "--decompress", action="store_true");
parser.add_argument("fin", nargs="?", default="-");
parser.add_argument("fout", nargs="?", default="-");
args = parser.parse_args();

MAGIC = b"mozLz40\x00";

if not ( args.compress ^ args.decompress ) :
    fin = sys.stdin.buffer if args.fin == "-" else open(args.fin, "rb")
    if ( fin.read(len(MAGIC)) == MAGIC ) :
        args.decompress = True
    else :
        args.compress = True
    fin.close()

if args.decompress :
    # read binary
    fin = sys.stdin.buffer if args.fin == "-" else open(args.fin, "rb");
    # write utf-8
    fout = sys.stdout if args.fout == "-" else open(args.fout, "w");

if args.compress :
    # read utf-8
    fin = sys.stdin if args.fin == "-" else open(args.fin, "r", encoding = "utf-8");
    # write binary
    fout = sys.stdout.buffer if args.fout == "-" else open(args.fout, "wb");

import lz4.block, json;

if args.decompress :
    if ( fin.read(len(MAGIC)) != MAGIC ) :
        raise Exception("invalid MAGIC");
    j = json.loads(lz4.block.decompress(fin.read()))
    json.dump(j, fout);

if args.compress :
    j = json.load(fin);
    fout.write(MAGIC);
    fout.write(lz4.block.compress(bytes(json.dumps(j), "utf-8")));
