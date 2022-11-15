#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys

FIREFOX_HOME = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/..")

prefs : dict = {}

def user_pref(key, value) :
    # ignore `_user.` entries (e.g. `_user.js.parrot` from ghacks)
    if ( key.startswith("_user.") ) :
        return
    if ( key not in prefs and value is None ) :
        print(f"WARN: user_pref(\"{key}\", None -> {value})", file=sys.stderr)
        return
    if ( key in prefs ) :
        print(f"INFO: user_pref(\"{key}\", {prefs[key]} -> {value})", file=sys.stderr)
    prefs[key] = value

parser = argparse.ArgumentParser()
# list of source user_pref files
parser.add_argument("files", nargs="*", default=[
    f"{FIREFOX_HOME}/ghacks-user.js/user.js",
    f"{FIREFOX_HOME}/user.js/ghacks.js",
    f"{FIREFOX_HOME}/user.js/my.js",
])
# handle `--pref <key> <value>` options
class PrefAction(argparse.Action) :
    def __call__(self, parser, namespace, values, option_string=None) :
        user_pref(values[0], values[1])
parser.add_argument("--pref", nargs=2, action=PrefAction)
args = parser.parse_args()

def read_prefs(user_js_fname : str) :
    print(f"DEBUG: read_prefs(\"{user_js_fname}\")", file=sys.stderr)
    with open(user_js_fname, encoding = "UTF-8") as user_js :
        # run gcc preprocessor (remove comments, etc.)
        output = subprocess.check_output("gcc -E -P -", stdin=user_js, shell=True)
        exec(output, { "__builtins__" : None }, {
            # js uses false/true and null
            "false" : False,
            "true" : True,
            "null" : None,
            "user_pref" : user_pref,
            "FIREFOX_HOME" : FIREFOX_HOME,
        })

def emit_prefs() :
    for key, value in prefs.items() :
        if ( value is None ) :
            continue

        value_type = type(value)

        if ( value_type == bool and value is False ) :
            value = "false"
        elif ( value_type == bool and value is True ) :
            value = "true"
        elif ( value_type == int ) :
            pass
        elif ( value_type == str ) :
            value = '"' + value + '"'
        else :
            raise Exception(f'unknown type: {value_type}')

        print(f'user_pref("{key}", {value});')

for file in args.files :
    read_prefs(file)

emit_prefs()
