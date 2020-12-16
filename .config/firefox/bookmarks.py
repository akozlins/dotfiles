#!/bin/python

import sys, json;

bookmarks = json.load(sys.stdin);

def filter(entry) :
    children = [];
    for e in entry.get("children", []) :
        children.append(filter(e));
    out = {};
    for k in [
        "title",
        "index",
        "type",
        "root",
        "uri",
        "keyword",
    ] :
        if k in entry : out[k] = entry[k];
    if ( len(children) > 0 ) : out["children"] = children;
    return out;

json.dump(filter(bookmarks), sys.stdout);
