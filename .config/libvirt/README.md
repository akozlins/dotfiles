#

## tools

- qemu
- libvirt
- virt-manager

## libvirt

`sudo cp /etc/libvirt/libvirt.conf $HOME/.config/libvirt/`

### `$HOME/.config/libvirt/`

```
uri_default = "qemu:///system"
```

## polkit

`sudo usermod "$USER" -a -G polkit`

### `/etc/polkit-1/rules.d/50-libvirt.rules`

```
/* allow users in wheel group to manage the libvirt daemon without auth */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
```

## virt-manager/install/clone

```
virt-install \
    --name openSUSE_Leap_15_3 \
    --disk path=openSUSE_Leap_15_3.qcow2,size=16 \
    --ram 2048 --vcpus 2 \
    --os-type linux --os-variant generic \
    --console pty,target_type=serial \
    --cdrom openSUSE-Leap-15.3-DVD-x86_64.iso
```

```
virt-clone \
    --name openSUSE_Leap_15_3_clone \
    --fileopenSUSE_Leap_15_3_clone.qcow2 \
    --original openSUSE_Leap_15_3
```

## network

```
sudo virsh net-start default
```
