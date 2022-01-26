# install arch linux

## prepare

```
# format
gdisk /dev/sda
# 512M EF00
mkfs.fat -F 32 /dev/sda1
cryptsetup luksFormat --type luks2 /dev/sda2
cryptsetup open /dev/sda2 root
mkfs.ext4 /dev/mapper/root

# mount
mount /dev/mapper/root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# install packages
pacman -Sy --noconfirm archlinux-keyring
pacstrap /mnt base linux-lts dosfstools efibootmgr dhcpcd openssh
```

## configure

```
genfstab -t UUID /mnt >> /mnt/etc/fstab

arch-chroot /mnt

passwd
pacman -Sy --noconfirm archlinux-keyring

# time zone
ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc

# localization
sed 's/^#en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen
locale-gen
cat > /etc/locale.conf << EOF
LANG=en_US.UTF-8
#LC_COLLATE=C
EOF

# disk
cat > /etc/fstab << EOF
/dev/mapper/root / ext4 rw,noatime,discard 0 1
UUID=$(findmnt --noheadings --output UUID --target /boot) /boot vfat rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro 0 2
#/swap none swap defaults 0 0
EOF
#dd if=/dev/zero of=/swap bs=1M count=512
#chmod 600 /swap
#mkswap /swap
#swapon /swap

# syslinux
#syslinux-install_update -i -a -m

# systemd-boot
bootctl install
mkdir -p -- /boot/loader/entries
cat > /boot/loader/entries/arch.conf << EOF
title arch
linux /vmlinuz-linux-lts
#initrd /intel-ucode.img
initrd /initramfs-linux-lts.img
options cryptdevice=UUID=$(lsblk --noheadings --inverse --output UUID /dev/mapper/root | sed --quiet 2p):root:allow-discards root=/dev/mapper/root rw
EOF
sed 's/block filesystems/block encrypt filesystems/' -i /etc/mkinitcpio.conf
mkinitcpio --allpresets

# network
cat > /etc/hostname << EOF
arch
EOF
mkdir ~/.ssh
touch ~/.ssh/authorized_keys
chmod -R go-rwx ~/.ssh
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
cat > /etc/systemd/network/20-wired.network << EOF
[Match]
Name=eth0
[Network]
DHCP=yes
EOF
systemctl enable systemd-networkd
cat > /etc/iptables/iptables.rules << EOF
# ...
EOF
systemctl enable iptables
cat > /etc/iptables/ip6tables.rules << EOF
# ...
EOF
systemctl enable ip6tables
cat >> /etc/ssh/sshd_config << EOF
Port 1022
AddressFamily inet
#PermitRootLogin yes
EOF
systemctl enable sshd

# ssh luks unlock
pacman -S --noconfirm mkinitcpio-netconf mkinitcpio-tinyssh mkinitcpio-utils
sed 's/block encrypt filesystems/block netconf tinyssh encryptssh filesystems/' -i /etc/mkinitcpio.conf
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "" -N ""
ssh-keygen -y -f ~/.ssh/id_ed25519 > /etc/tinyssh/root_key
mkinitcpio --allpresets

# packages
pacman -S --noconfirm htop mc nano sudo tmux vim
pacman -S --noconfirm man-db man-pages
pacman -S --noconfirm cmake gcc git make
pacman -S --noconfirm bind nginx unbound
pacman -S --noconfirm borg gnu-netcat iptstate mlocate mtr pkgfile ripgrep rsync

```

## gui

```
# dm
pacman -S --noconfirm lxdm ttf-dejavu openbox
systemctl enable lxdm

# packages
sudo pacman -S --noconfirm xorg-xrdb xorg-xset xorg-xsetroot
sudo pacman -S --noconfirm xsecurelock xterm

# fonts
pacman -S --noconfirm xorg-fonts-misc
xset +fp /usr/share/fonts/misc
pacman -S --noconfirm xorg-mkfontscale
mkfontdir
xset fp rehash

# icons
pacman -S --noconfirm adwaita-icon-theme
```

## user

```
pacman -S zsh-completions
useradd --create-home --shell /bin/zsh $USER
passwd $USER
cat > /etc/sudoers.d/akozlins << EOF
akozlins ALL=(ALL) ALL
EOF

su - $USER

mkdir ~/.ssh
touch ~/.ssh/authorized_keys
chmod -R go-rwx ~/.ssh

# dotfiles
git clone https://github.com/akozlins/dotfiles .dotfiles
( cd .dotfiles && ./install.sh )

# fbpanel
sudo pacman -S --noconfirm pkgconf gdk-pixbuf-xlib
( cd .dotfiles/opt && make fbpanel )

# far2l
sudo pacman -S --noconfirm patch m4 uchardet wxgtk2 spdlog xerces-c
( cd .dotfiles/opt && make far2l )
```
