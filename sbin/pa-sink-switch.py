#!/usr/bin/env python3

import os, subprocess, time, yaml

class LRU :
    file = None

    sinks = []
    entries = []

    def __init__(self, file) :
        # list available sinks
        print(f"subprocess: pactl list short sinks")
        for line in subprocess.check_output(f"pactl list short sinks", shell=True).decode("ascii").splitlines() :
            sink = line.split("\t")
            print(f"    - {sink[1]}")
            sink[0] = int(sink[0])
            self.sinks.append(sink[1])

        # load lru entries
        self.file = file
        if not os.path.exists(self.file) : return
        with open(self.file, "r", encoding = "utf-8") as file :
            self.entries = yaml.safe_load(file)

    def close(self) :
        # save lru entries
        with open(self.file, "w", encoding = "utf-8") as file :
            yaml.dump(self.entries, file)

    # select next sink and update lru entries
    def next(self) :
        if not self.sinks : return None
        while True :
            for sink in self.sinks :
                if sink not in self.entries :
                    if sink == "easyeffects_sink" : continue
                    self.entries.append(sink)
                    return sink
            # remove oldest entry
            self.entries.pop(0)

    def set_default_sink(self, sink) :
        if sink not in self.sinks : return
        print(f"subprocess: pactl set-default-sink {sink}")
        subprocess.check_output(f"pactl set-default-sink {sink}", shell=True)
#        time.sleep(0.1)
        print(f"subprocess: pactl list sink-inputs short")
        for line in subprocess.check_output(f"pactl list sink-inputs short", shell=True).decode("ascii").splitlines() :
            input = line.split("\t")
            print(f"subprocess: pactl move-sink-input {input[0]} {sink}")
            subprocess.check_output(f"pactl move-sink-input {input[0]} {sink}", shell=True)

lru = LRU(f"{os.environ['HOME']}/.cache/pa-sink-switch-lru.yml")

sink = lru.next()

subprocess.check_output(f"dunstify 'sink = {sink}'", shell=True)

lru.set_default_sink(sink)
lru.set_default_sink("easyeffects_sink")

lru.close()
