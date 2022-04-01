#!/usr/bin/env python3

import sys, json

session = json.load(sys.stdin)

windows = []
for window in session["windows"] :
    tabs = []
    for tab in window["tabs"] :
        if not tab["entries"] : continue
        entry = tab["entries"][-1]
        tabs.append({
            "entries" : [{
                "url" : entry["url"],
            }],
        })
    windows.append({ "tabs" : tabs })

json.dump({ "windows" : windows }, sys.stdout)
