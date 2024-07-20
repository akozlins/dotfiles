# linux

## pacman

```
# mark all packages as non-explicitly installed
sudo pacman -D --asdeps $(pacman -Qqe)
# mark base packages as explicitly installed
sudo pacman -D --asexplicit base
# list unrequired and optional dependencies
pacman -Qdtt
# mark package as explicitly installed
sudo pacman -D --asexplicit <package>
# ...
pacman -Qe | awk '{print $1}' | xargs -n 1 pactree -r -d 1
```

## fonts

```
# terminal bitmap fonts
pacman -S xorg-fonts-misc
# ...
pacman -S noto-fonts noto-fonts-cjk
# reset xorg font cache
xset fp default
xset fp rehash
```

## `/etc/logrotate.d/...`

```
daily
dateext
minsize 1M
rotate 4
```

## unbound

## bind

```
nano /var/named/example.com.zone`
```

## mailu

## maddy

```
sudo setfacl -R -m u:maddy:rX /etc/letsencrypt/{live,archive}
maddyctl creds create postmaster@example.com
maddyctl imap-acct create postmaster@example.com
```

## android

- <https://wiki.archlinux.org/index.php/Android>

```
yay -S android-studio
yay -S android-sdk android-sdk-platform-tools android-platform android-emulator
```

```
groupadd android-sdk
gpasswd -a "$USER" android-sdk

setfacl -R -m g:android-sdk:rwx /opt/android-sdk
setfacl -d -m g:android-sdk:rwX /opt/android-sdk
```

```
adb install "$APK"
```

## luks

```
# check block size
blockdev --getpbsz /dev/sda1

# luks with integrity
sudo cryptsetup luksFormat --type luks2 --integrity hmac-sha256 --sector-size 4096 /dev/sda1
```

## virtualbox

- mount `.vdi` files
```
modprobe nbd
qemu-nbd -c /dev/nbd0 disk.vdi
mount /dev/nbd0p1 /mnt
umount /mnt
qemu-nbd -d /dev/nbd0
```

## nfs

```
pacman -S nfs-utils perl-file-mimeinfo
cat >> /etc/exports << EOF
/nfs/exports 100.64.0.0/10(rw)
EOF
systemctl mask rpcbind.service rpcbind.socket nfs-server.service
systemctl enable nfsv4-server
cat >> /etc/fstab << EOF
100.64.0.0:/nfs /nfs nfs _netdev,noauto,x-systemd.automount,x-systemd.mount-timeout=2,timeo=31,x-systemd.idle-timeout=1min 0 0
EOF
systemctl daemon-reload
systemctl restart remote-fs.target
```

## kubernetes

```
lxc profile set default security.secureboot=false
lxc profile set default limits.cpu=2
lxc profile set default limits.memory=2GB

pacman -S edk2-ovmf

lxc init images:archlinux arch0 --vm
lxc start arch0
lxc exec arch0 bash
```

```
# https://wiki.archlinux.org/title/Kubernetes
pacman -S kubernetes-control-plane
pacman -S kubeadm kubectl containerd

# install CRI
# <https://kubernetes.io/docs/setup/production-environment/container-runtimes/>

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml
sed -i -e 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

systemctl enable containerd
systemctl start containerd

kubeadm init --pod-network-cidr=10.244.0.0/16
systemctl enable kubelet

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

kubectl get nodes
kubectl taint nodes --all node-role.kubernetes.io/master-

# https://github.com/flannel-io/flannel
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
kubectl get pods -A
```

## misc

```
cat << EOF | pango-view --font="Nimbus Mono PS" /dev/stdin
| worksheet |
| buffering |
| difficult |
| finishing |
| different |
| efficient |
EOF
```

- hot unplug: `echo 1 | sudo tee /sys/block/$SDA/device/delete`
- list packages by size: `expac "%n %m" -l'\n' -Q $(pacman -Qq) | sort -nk 2 | column -t`
- find hard links: `find / -type f -links +1 -printf '%i %n %p\n'`
- copy system: `rsync -avhPHAXx / /mnt/`
