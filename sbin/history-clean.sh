#!/bin/sh

cat "$HOME/.bash_history" | tac | awk '!x[$0]++' | tac
