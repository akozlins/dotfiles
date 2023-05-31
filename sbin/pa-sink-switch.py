#!/usr/bin/env python3

import json
import os
import pathlib
import subprocess
import time


def shell(args : list) -> str :
    print(f'subprocess: {args}')
    return subprocess.check_output(args)

class LRU :
    entries_path : pathlib.Path

    sinks : list[str] = []
    entries : list = []

    def __init__(self : "LRU", file_name : str) -> None:
        self.entries_path = pathlib.Path(file_name)

        # list available sinks
        for line in shell([ "/usr/bin/pactl", "list", "short", "sinks" ]).decode("ascii").splitlines() :
            sink = line.split("\t")
            print(f"    - {sink[1]}")
            #sink[0] = int(sink[0])
            self.sinks.append(sink[1])

        # load lru entries
        if self.entries_path.exists() :
            with self.entries_path.open(mode="r", encoding="utf-8") as file :
                self.entries = json.load(file)

    def close(self : "LRU") -> None:
        if not self.entries : return
        # store lru entries
        with self.entries_path.open(mode="w", encoding="utf-8") as file :
            json.dump(self.entries, file)

    # select next sink and update lru entries
    def next_sink(self : "LRU") -> str :
        while True :
            # find new entry (not in lru)
            for sink in self.sinks :
                if sink in self.entries : continue
                if sink == "easyeffects_sink" : continue
                self.entries.append(sink)
                return sink
            if not self.entries : return ""
            # remove old entry
            self.entries.pop(0)

    def set_default_sink(self : "LRU", sink : str) -> None :
        shell([ "/usr/bin/pactl", "set-default-sink", sink ])

    def move_sink_input(self : "LRU", sink : str) -> None :
        for line in shell([ "/usr/bin/pactl", "list", "sink-inputs", "short" ]).decode("ascii").splitlines() :
            stream_id = line.split("\t")
            shell([ "/usr/bin/pactl", "move-sink-input", stream_id[0], sink ])

def main() -> None :
    lru = LRU(f"{os.environ['HOME']}/.cache/pa-sink-switch-lru.json")

    sink = lru.next_sink()

    shell([ "/usr/bin/dunstify", f"I [main] 'sink = {sink}'" ])
    if not sink : return
    lru.move_sink_input("easyeffects_sink")

    lru.set_default_sink(sink)

    # load easyeffects output preset
    for preset_path in pathlib.Path(f"{os.environ['HOME']}/.config/easyeffects/autoload/output").iterdir() :
        if preset_path.suffix != ".json" : continue
        preset = json.load(preset_path.open(mode="r", encoding="utf-8"))
        preset_device = preset["device"]
        preset_name = preset["preset-name"]
        preset_match = preset.get("device_match")
        print(f"try preset: name = {preset_name}, match = {preset_match}, device = {preset_device}")
        if ( preset_match and pathlib.PurePath(sink).match(preset_match) ) or \
           ( sink in preset_device or preset_device in sink ) :
            shell([ "/usr/bin/easyeffects", "-l", preset_name ])

#    shell(f"/usr/bin/gsettings set com.github.wwmm.easyeffects.streamoutputs output-device {sink}")
#    shell("/usr/bin/pw-metadata 0 default.configured.audio.sink")
    shell([ "/usr/bin/pw-metadata", "0", "default.configured.audio.sink", f'{{"name":"{sink}"}}' ])

    #lru.set_default_sink("easyeffects_sink")
    time.sleep(0.5)
    lru.move_sink_input("easyeffects_sink")

    lru.close()

main()
