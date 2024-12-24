#!/bin/env python3

import argparse
import os
import re
import subprocess
import tempfile

parser = argparse.ArgumentParser()
parser.add_argument("pattern", nargs="?", default="")
args = parser.parse_args()

def fix_hunk(fname) :
    with open(fname, "r") as f :
        lines = f.read().splitlines(keepends=True)
    nBefore = nAfter = 0
    # get before/after counts
    for line in reversed(lines) :
        if line.startswith('@@') : break
        if line.startswith(' ') :
            nBefore += 1
            nAfter += 1
        if line.startswith('-') : nBefore += 1
        if line.startswith('+') : nAfter += 1
    with open(fname, "w") as f :
        for line in lines :
            if line.startswith('@@') :
                # update before/after counts
                block = re.match(r'^@@ [-](\d+),\d+ [+](\d+),\d+ @@(.*)$', line).groups()
                line = f'@@ -{block[0]},{nBefore} +{block[1]},{nAfter} @@{block[2]}\n'
            f.write(line)
        f.flush()

def split_hunk(fname) :
    with open(fname, "r") as f :
        lines = f.read().splitlines(keepends=True)
    state = ''
    header = ''
    block = None
    hunk = []
    for line in lines :
        if line.startswith("diff ") :
            state = 'header'
            header = ''
        if line.startswith("@@ ") :
            state = 'hunk'
            block = re.match(r'^@@ [-](\d+),\d+ [+](\d+),\d+ @@(.*)$', line).groups()
            continue
        if state == 'header' :
            header += line
        if state == 'hunk' :
            hunk.append(line)

    context = []
    context.append([ 0, 0, int(block[0]), int(block[1]) ]) # (nLines, startLine, srcLine, dstLine)
    for line in hunk :
        if line.startswith(' ') :
            context[-1][0] += 1
            continue
        if context[-1][0] > 0 :
            context.append([
                0,
                context[-1][1] + context[-1][0],
                context[-1][2] + context[-1][0],
                context[-1][3] + context[-1][0],
            ])
        context[-1][1] += 1
        if line.startswith('-') :
            context[-1][2] += 1
        else :
            context[-1][3] += 1

    ctx = [ 0, 0, 0, 0 ]
    for ctx_ in context[1:-1] :
        if ctx_[0] > ctx[0] : ctx = ctx_

    if ctx[0] == 0 : return []

    hunks = []
    n = int(ctx[0]/2)
    hunks.append(header
        + f'@@ -{block[0]},0 +{block[1]},0 @@ {block[2]}\n'
        + ''.join(hunk[:ctx[1]+n])
    )
    hunks.append(header
        + f'@@ -{ctx[2]+n},0 +{ctx[3]+n},0 @@ {block[2]}\n'
        + ''.join(hunk[ctx[1]+n:])
    )

    return hunks

def do_hunk(fname) :
    # print colored diff
    os.system(f'colordiff < {fname}')
    # ask user what to do
    try : i = input('Stage this hunk [y,n,q,s,e,?]? ').lower()
    except KeyboardInterrupt : return exit()
    print('')
    match i :
        case 'y' : None
        case 'n' : return True
        case 'q' : exit()
        case 's' :
            hunks = split_hunk(fname)
            if len(hunks) < 2 : return False
            do_hunks(hunks)
            return True
        case 'e' :
            #os.system(f'nano --syntax=patch +1,1 {fname}')
            os.system(f'$EDITOR -- {fname}')
        case _ : return False
    fix_hunk(fname)
    
    # apply patch
    os.system(f'git apply --cached {fname}')
    return True

def do_hunks(hunks) :
    for hunk in hunks :
        with tempfile.NamedTemporaryFile(suffix='.patch', mode='w', delete_on_close=False) as f :
            f.write(hunk)
            f.flush()
            while not do_hunk(f.name) : None

state = ''
header = ''
hunks = []
diff = os.popen(f'/usr/bin/git diff | grepdiff --only-match=mod --output-matching=hunk "{args.pattern}"').read()
#for hunk in re.split(r'(^diff .*)$', diff, flags=re.MULTILINE|re.DOTALL) :
for line in diff.splitlines(keepends=True) :
    if line.startswith("diff ") :
        state = 'header'
        header = ''
    if line.startswith("@@ ") :
        state = 'hunk'
        hunks.append(header)
    if state == 'header' :
        header += line
    if state == 'hunk' :
        hunks[-1] += line
do_hunks(hunks)
