#!/bin/python

import os, subprocess;

def read_prefs(prefs, f) :
    def user_pref(key, value) :
        prefs[key] = value;
    # js uses false/true and null
    false = False;
    true = True;
    null = None;
    stream = open(f);
    # run gcc preprocessor (remove comments, etc.)
    output = subprocess.check_output("gcc -E -P -", stdin=stream, shell=True);
    exec(output);

FIREFOX_HOME = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/..");

prefs = dict();
read_prefs(prefs, FIREFOX_HOME + "/user.js/ghacks.js");
read_prefs(prefs, FIREFOX_HOME + "/user.js/my.js");

for key, value in prefs.items() :
    if ( value == None ) : continue;
    value_type = type(value);
    if value_type == bool and value == False :
        print(f'user_pref("{key}", false);');
        continue;
    if value_type == bool and value == True :
        print(f'user_pref("{key}", true);');
        continue;
    if value_type == int :
        print(f'user_pref("{key}", {value});');
        continue;
    if value_type == str :
        print(f'user_pref("{key}", "{value}");');
        continue;
    raise Exception(f'unknown type: {value_type}')
