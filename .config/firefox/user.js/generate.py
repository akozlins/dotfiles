#!/usr/bin/env python3

import argparse
import os
import pathlib
import subprocess
import sys

CONFIG_HOME = pathlib.Path(os.getenv("XDG_CONFIG_HOME", pathlib.Path("~/.cache").expanduser()))
FIREFOX_HOME = CONFIG_HOME.joinpath("firefox")

prefs : dict[str, str] = {}

def user_pref(key : str, value : str) -> None :
    # ignore `_user.` entries (e.g. `_user.js.parrot` from ghacks)
    if ( key.startswith("_user.") ) :
        return
    if ( key not in prefs and value is None ) :
        print(f'WARN: user_pref("{key}", None -> {value})', file=sys.stderr)
        return
    if ( key in prefs ) :
        print(f'INFO: user_pref("{key}", {prefs[key]} -> {value})', file=sys.stderr)
    prefs[key] = value

parser = argparse.ArgumentParser()
# list of source user_pref files
parser.add_argument("files", nargs="*", default=[
    FIREFOX_HOME.joinpath("ghacks-user.js/user.js"),
    FIREFOX_HOME.joinpath("user.js/ghacks.js"),
    FIREFOX_HOME.joinpath("user.js/my.js"),
])
# handle `--pref <key> <value>` options
class PrefAction(argparse.Action) :
    def __call__(self : "PrefAction", parser, namespace, values, option_string=None) -> None :
        user_pref(values[0], values[1])
parser.add_argument("--pref", nargs=2, action=PrefAction)
args = parser.parse_args()

def read_prefs(user_js_path : pathlib.Path) -> None :
    print(f'DEBUG: read_prefs("{user_js_path}")', file=sys.stderr)
    with user_js_path.open(encoding = "UTF-8") as user_js :
        # run gcc preprocessor (remove comments, etc.)
        output = subprocess.check_output([ "/usr/bin/env", "gcc", "-E", "-P", "-" ], stdin=user_js)
        exec(output, { "__builtins__" : None }, {
            # js uses false/true and null
            "false" : False,
            "true" : True,
            "null" : None,
            "user_pref" : user_pref,
            "FIREFOX_HOME" : str(FIREFOX_HOME),
        })

def emit_prefs() -> None:
    for key, value in prefs.items() :
        if ( value is None ) :
            continue

        pref_value = value
        value_type = type(value)

        if ( value_type == bool and value is False ) :
            pref_value = "false"
        elif ( value_type == bool and value is True ) :
            pref_value = "true"
        elif ( value_type == int ) :
            pass
        elif ( value_type == str ) :
            pref_value = f'"{value}"'
        else :
            msg = f'unknown type: {value_type}'
            raise Exception(msg)

        print(f'user_pref("{key}", {pref_value});')

for file in args.files :
    read_prefs(file)

emit_prefs()
