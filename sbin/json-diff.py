#!/usr/bin/env python3

from collections import OrderedDict

import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument("old", metavar="old.json", type=str)
parser.add_argument("new", metavar="new.json", type=str)
args = parser.parse_args()

def diff(old, new) :
    if old == new :
        return None

    if not ( isinstance(old, dict) and isinstance(new, dict) ) :
        return new

    out = type(new)()

    for k in new :
        if k in old :
            out[k] = diff(old[k], new[k])
        else :
            out[k] = new[k]

        if out[k] is None :
            out.pop(k)

    return out

print(json.dumps(diff(
    json.load(open(args.old, "r", encoding = "utf-8"), object_pairs_hook = OrderedDict),
    json.load(open(args.new, "r", encoding = "utf-8"), object_pairs_hook = OrderedDict),
)))
