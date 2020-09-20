#!/bin/python

import argparse, sys, json, yaml;

parser = argparse.ArgumentParser()
parser.add_argument("input", metavar="input.json", nargs="?", type=str)
args = parser.parse_args()

if not args.input or args.input == "-" :
    json_stream = sys.stdin
else :
    json_stream = open(args.input, "r", encoding = "utf-8")

json_data = json.load(json_stream)

yaml.safe_dump(json_data, sys.stdout, default_flow_style = False)
