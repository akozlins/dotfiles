#!/bin/python

import argparse;

parser = argparse.ArgumentParser();
parser.add_argument("jsonlz4");
args = parser.parse_args();

f = open(args.jsonlz4, "rb");

MAGIC = b"mozLz40\x00";
if ( f.read(len(MAGIC)) != MAGIC ) :
    raise Exception(f'invalid MAGIC')

import lz4.block, json;

j = json.loads(lz4.block.decompress(f.read()));

print(json.dumps(j));
