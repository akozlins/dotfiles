#!/bin/python

import sys, json;
from collections import OrderedDict;

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

new = json.load(open(sys.argv[1], "r", encoding = "utf-8"), object_pairs_hook = OrderedDict)
old = json.load(open(sys.argv[2], "r", encoding = "utf-8"), object_pairs_hook = OrderedDict)

out = diff(new, old)

print(json.dumps(out))
