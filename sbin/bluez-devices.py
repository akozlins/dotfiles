#!/bin/python

# https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/device-api.txt

import pydbus

bus = pydbus.SystemBus()

bluez = bus.get("org.bluez", "/")

objects = bluez.GetManagedObjects()
for path in objects :
    device = objects[path].get("org.bluez.Device1")
    if not device : continue
    state = device.get("Connected", False)
    if not state : continue
    addr = device.get("Address")
    name = device.get("Name")
    print(f"Device {addr} {name}")
