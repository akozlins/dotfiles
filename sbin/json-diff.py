#!/usr/bin/env python3

import argparse
import collections
import json
import pathlib

parser = argparse.ArgumentParser()
parser.add_argument("old", metavar="old.json", type=str)
parser.add_argument("new", metavar="new.json", type=str)
args = parser.parse_args()

def diff(old : dict, new : dict) -> dict :
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
    json.load(pathlib.Path(args.old).open(mode="r", encoding = "utf-8"), object_pairs_hook=collections.OrderedDict),
    json.load(pathlib.Path(args.new).open(mode="r", encoding = "utf-8"), object_pairs_hook=collections.OrderedDict),
)))
