#!/bin/python

import sys;
import yaml, json;

if len(sys.argv) > 1 :
    json_stream = open(sys.argv[1], "r", encoding = "utf-8")
else :
    json_stream = sys.stdin

json_data = json.load(json_stream)

yaml.safe_dump(json_data, sys.stdout, default_flow_style = False)
