#!/bin/bash
set -euf

aspell --lang=en dump master | tee "aspell-en.dump"
