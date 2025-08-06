#

```
mkdir .ssh
nano .ssh/authorized_keys
chmod -R go-rwx .ssh
passwd

su -
pacman-key --init
pacman-key --populate archlinuxarm
pacman -Syu
pacman -S sudo

cat >> /etc/systemd/journald.conf << EOF
[Journal]
SystemMaxUse=64M
RuntimeMaxUse=64M
MaxLevelStore=notice
#MaxLevelSyslog=info
EOF
```

```
sudo pacman -S git make
git clone https://github.com/akozlins/dotfiles .dotfiles

sudo pacman -S iotop
sudo iotop -oPa

sudo pacman -S usbutils
lsusb

cat >> config.txt << EOF
dtparam=pwr_led_trigger=none
EOF
```
