#!/usr/bin/env python3

import json
import sys

bookmarks = json.load(sys.stdin)

def filter_entries(entry : dict) -> dict :
    children = []
    for e in entry.get("children", []) :
        children.append(filter_entries(e))

    out = {}

    for k in [
        "title",
        "index",
        "type",
        "root",
        "uri",
        "keyword",
    ] :
        if k in entry :
            out[k] = entry[k]

    if ( len(children) > 0 ) :
        out["children"] = children

    return out

json.dump(filter_entries(bookmarks), sys.stdout)
