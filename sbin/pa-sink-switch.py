#!/usr/bin/env python3

import json
import os
import subprocess
import time
import yaml

class LRU :
    file_name = None

    sinks = []
    entries = []

    def __init__(self, file_name_) :
        self.file_name = file_name_

        # list available sinks
        print(f"subprocess: /usr/bin/pactl list short sinks")
        for line in subprocess.check_output(f"/usr/bin/pactl list short sinks", shell=True).decode("ascii").splitlines() :
            sink = line.split("\t")
            print(f"    - {sink[1]}")
            sink[0] = int(sink[0])
            self.sinks.append(sink[1])

        # load lru entries
        if os.path.exists(self.file_name) :
            with open(self.file_name, "r", encoding = "utf-8") as file :
                self.entries = yaml.safe_load(file)

    def close(self) :
        # save lru entries
        with open(self.file_name, "w", encoding = "utf-8") as file :
            yaml.dump(self.entries, file)

    # select next sink and update lru entries
    def next(self) :
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

    def set_default_sink(self, sink) :
        if sink not in self.sinks :
            return
        print(f"subprocess: /usr/bin/pactl set-default-sink {sink}")
        subprocess.check_output(f"/usr/bin/pactl set-default-sink {sink}", shell=True)

    def move_sink_input(self, sink) :
        print(f"subprocess: /usr/bin/pactl list sink-inputs short")
        for line in subprocess.check_output(f"/usr/bin/pactl list sink-inputs short", shell=True).decode("ascii").splitlines() :
            stream_id = line.split("\t")
            print(f"subprocess: /usr/bin/pactl move-sink-input {stream_id[0]} {sink}")
            subprocess.check_output(f"/usr/bin/pactl move-sink-input {stream_id[0]} {sink} | true", shell=True)

def main() :
    lru = LRU(f"{os.environ['HOME']}/.cache/pa-sink-switch-lru.yml")

    sink = lru.next()

    subprocess.check_output(f"/usr/bin/dunstify 'sink = {sink}'", shell=True)
    lru.move_sink_input("easyeffects_sink")

    lru.set_default_sink(sink)

    # load easyeffects output preset
    presets_dir = f"{os.environ['HOME']}/.config/easyeffects/autoload/output"
    for fname in os.listdir(presets_dir) :
        if not fname.endswith(".json") :
            continue
        preset = json.load(open(os.path.join(presets_dir, fname), "r", encoding = "utf-8"))
        preset_device = preset["device"]
        preset_name = preset["preset-name"]
        if sink in preset_device or preset_device in sink :
            print(f"subprocess: /usr/bin/easyeffects -l '{preset_name}'")
            subprocess.check_output(f"/usr/bin/easyeffects -l '{preset_name}' || true", shell=True)

    #lru.set_default_sink("easyeffects_sink")
    time.sleep(0.5)
    lru.move_sink_input("easyeffects_sink")

    lru.close()

main()
