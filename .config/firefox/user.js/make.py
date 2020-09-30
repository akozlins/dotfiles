#!/bin/python

import os, subprocess;

prefs = dict()
def user_pref(key, value) :
    prefs[key] = value;

def eval_file(f) :
    exec(subprocess.check_output(f"cat {f} | gcc -E -P -", shell = True, text = True))

false = False
true = True
null = None
FIREFOX_HOME = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/..")

eval_file(FIREFOX_HOME + "/user.js/ghacks.js");
eval_file(FIREFOX_HOME + "/user.js/my.js");

for name in prefs :
    value = prefs[name]
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
