#!/bin/env python3

from datetime import datetime, timedelta, timezone
import pathlib
import re

domains = {}

for line in pathlib.Path("/etc/unbound/unbound.log").open().readlines() :
    info = re.findall('^\\[([^ ]+)\\] [^ ]+ [^ ]+ [^ ]+ ([^ ]+) [^ ]+ [^ ]+ ([^ ]+) [^ ]+ ([^ ]+) [^ ]+$', line)
    if not info : continue
    info = info[0]

    time = datetime.fromtimestamp(int(info[0]), tz=timezone.utc)
    domain = info[1]
    status = info[2]
    cached = info[3]

    if time < datetime.now(tz=timezone.utc) - timedelta(days=30) : continue

    key = ""
    items = domains
    for i in reversed(domain.split('.')) :
        i = i + '.'
        if key == '.' : key = i
        else : key = i + key
        items[key] = items.get(key, {
            "items" : {},
            "n" : 0,
            "c" : 0,
            "NX" : 0,
        })
        entry = items[key]
        entry["n"] = entry["n"] + 1
        if cached == "1" : entry["c"] = entry["c"] + 1
        if status == "NXDOMAIN" : entry["NX"] = entry["NX"] + 1
        items = entry["items"]

def print_d(items:dict , level:int=0, n_min:int=0) -> None :
    if not items : return
    if level > 2 : return
    for t in sorted(items.items(), key=lambda item : item[1]["n"], reverse=True) :
        domain = t[0].ljust(32-2*level)
        n = t[1]["n"]
        c = n - t[1]["c"]
        NX = t[1]["NX"]
        if NX == 0 and n < n_min : continue
        #if n == NX : continue
        for l in range(level) : print("  ", end="")
        print(f'+ {domain} {n:6} {c:6}', end="")
        if NX : print(f' NX={NX}', end="")
        print()
        print_d(t[1].get("items", {}), level+1, n_min=n/100)

print_d(domains, level=0, n_min=10)
