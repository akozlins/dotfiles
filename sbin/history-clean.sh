#!/bin/sh

cat ~/.bash_history | tac | awk '!x[$0]++' | tac
