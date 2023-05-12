#!/usr/bin/env python3

import json
import os
import pathlib
import subprocess
import time

import yaml

class LRU :
    entries_path : pathlib.Path = None

    sinks = []
    entries = []

    def __init__(self : "LRU", file_name : str) -> None:
        self.entries_path = pathlib.Path(file_name)

        # list available sinks
        print(f"subprocess: /usr/bin/pactl list short sinks")
        for line in subprocess.check_output([ "/usr/bin/pactl", "list", "short", "sinks" ]).decode("ascii").splitlines() :
            sink = line.split("\t")
            print(f"    - {sink[1]}")
            sink[0] = int(sink[0])
            self.sinks.append(sink[1])

        # load lru entries
        if self.entries_path.exists() :
            with self.entries_path.open(mode="r", encoding="utf-8") as file :
                self.entries = yaml.safe_load(file)

    def close(self : "LRU") -> None:
        # save lru entries
        with self.entries_path.open(mode="w", encoding="utf-8") as file :
            yaml.dump(self.entries, file)

    # select next sink and update lru entries
    def next_sink(self : "LRU") -> str :
        if not self.sinks :
            return None
        while True :
            for sink in self.sinks :
                if sink not in self.entries :
                    if sink == "easyeffects_sink" :
                        continue
                    self.entries.append(sink)
                    return sink
            # remove oldest entry
            self.entries.pop(0)

    def set_default_sink(self : "LRU", sink : str) -> None :
        if sink not in self.sinks :
            return
        print(f"subprocess: /usr/bin/pactl set-default-sink {sink}")
        subprocess.check_output([ "/usr/bin/pactl", "set-default-sink", sink ])

    def move_sink_input(self : "LRU", sink : str) -> None :
        print(f"subprocess: /usr/bin/pactl list sink-inputs short")
        for line in subprocess.check_output([ "/usr/bin/pactl", "list", "sink-inputs", "short" ]).decode("ascii").splitlines() :
            stream_id = line.split("\t")
            print(f"subprocess: /usr/bin/pactl move-sink-input {stream_id[0]} {sink}")
            subprocess.check_output([ "/usr/bin/pactl", "move-sink-input", stream_id[0], sink ])

def main() -> None :
    lru = LRU(f"{os.environ['HOME']}/.cache/pa-sink-switch-lru.yml")

    sink = lru.next_sink()

    subprocess.check_output([ "/usr/bin/dunstify", f"'sink = {sink}'" ])
    lru.move_sink_input("easyeffects_sink")

    lru.set_default_sink(sink)

    # load easyeffects output preset
    for preset_path in pathlib.Path(f"{os.environ['HOME']}/.config/easyeffects/autoload/output").iterdir() :
        if preset_path.suffix != ".json" :
            continue
        preset = json.load(preset_path.open(mode="r", encoding="utf-8"))
        preset_device = preset["device"]
        preset_name = preset["preset-name"]
        if sink in preset_device or preset_device in sink :
            print(f"subprocess: /usr/bin/easyeffects -l '{preset_name}'")
            subprocess.check_output([ "/usr/bin/easyeffects", "-l", preset_name ])

    #lru.set_default_sink("easyeffects_sink")
    time.sleep(0.5)
    lru.move_sink_input("easyeffects_sink")

    lru.close()

main()
