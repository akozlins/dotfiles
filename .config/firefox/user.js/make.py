#!/bin/python

import os, subprocess;

def read_prefs(prefs, f) :
    def user_pref(key, value) :
        prefs[key] = value;
    false = False;
    true = True;
    null = None;
    exec(subprocess.check_output(f"cat {f} | gcc -E -P -", shell = True, text = True));

FIREFOX_HOME = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/..");

prefs = dict();
read_prefs(prefs, FIREFOX_HOME + "/user.js/ghacks.js");
read_prefs(prefs, FIREFOX_HOME + "/user.js/my.js");

for key, value in prefs.items() :
    if ( value == None ) : continue;
    if value == None : continue
    if isinstance(value, bool) and value == False :
        print(f'user_pref("{name}", false);')
        continue
    if isinstance(value, bool) and value == True :
        print(f'user_pref("{name}", true);')
        continue
    if isinstance(value, int) :
        print(f'user_pref("{name}", {value});')
        continue
    if isinstance(value, str) :
        print(f'user_pref("{name}", "{value}");')
        continue
    raise Exception(f'unknown type: {type(value)}')
