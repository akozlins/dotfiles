#!/bin/python

import os, subprocess, sys

def read_prefs(prefs, f, warn = True) :
    print(f"DEBUG: read_prefs(\"{f}\")", file = sys.stderr)
    def user_pref(key, value) :
        if ( key.startswith("_user.") ) : return
        if ( warn and not key in prefs and value == None ) :
            print(f"WARN: user_pref(\"{key}\", null)", file = sys.stderr)
        if ( warn and key in prefs and prefs[key] == value ) :
            print(f"INFO: user_pref(\"{key}\", {prefs[key]} -> {value})", file = sys.stderr)
            return;
        if ( warn and key in prefs and value != None ) :
            print(f"WARN: user_pref(\"{key}\", {prefs[key]} -> {value})", file = sys.stderr)
        prefs[key] = value
    # js uses false/true and null
    false = False
    true = True
    null = None
    stream = open(f)
    # run gcc preprocessor (remove comments, etc.)
    output = subprocess.check_output("/bin/gcc -E -P -", stdin=stream, shell=True)
    exec(output)

FIREFOX_HOME = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/..")

prefs = dict()
read_prefs(prefs, FIREFOX_HOME + "/ghacks-user.js/user.js", warn = False)
read_prefs(prefs, FIREFOX_HOME + "/user.js/ghacks.js")
read_prefs(prefs, FIREFOX_HOME + "/user.js/my.js")

for key, value in prefs.items() :
    if ( value == None ) : continue
    value_type = type(value)

    if ( value_type == bool and value == False ) :
        value = "false"
    elif ( value_type == bool and value == True ) :
        value = "true"
    elif ( value_type == int ) :
        value = value
    elif ( value_type == str ) :
        value = '"' + value + '"'
    else :
        raise Exception(f'unknown type: {value_type}')

    print(f'user_pref("{key}", {value});')
