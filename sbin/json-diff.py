#!/bin/python

import argparse, sys, json;

parser = argparse.ArgumentParser()
parser.add_argument("new", metavar="new.json", type=str)
parser.add_argument("old", metavar="old.json", type=str)
args = parser.parse_args()

def diff(new, old) :
    if new == old : return None

    if not ( isinstance(new, dict) and isinstance(old, dict) ) : return new

    out = type(new)()

    for k in new :
        if k in old :
            out[k] = diff(new[k], old[k])
        else :
            out[k] = new[k]
        if out[k] == None : out.pop(k)

    return out

from collections import OrderedDict;
new = json.load(open(args.new, "r", encoding = "utf-8"), object_pairs_hook = OrderedDict)
old = json.load(open(args.old, "r", encoding = "utf-8"), object_pairs_hook = OrderedDict)

out = diff(new, old)

print(json.dumps(out))
