# install arch linux

## prepare

```
# format
gdisk /dev/sda
# 512M EF00
mkfs.fat -F 32 /dev/sda1
cryptsetup luksFormat --type luks2 /dev/sda2
cryptsetup open --allow-discards /dev/sda2 root
mkfs.ext4 /dev/mapper/root

# mount
mount /dev/mapper/root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# install packages
#pacman -Sy --noconfirm archlinux-keyring
pacstrap /mnt base dhcpcd dosfstools efibootmgr iptables-nft linux-lts nano openssh
```

## configure

```
#genfstab -t UUID /mnt >> /mnt/etc/fstab

arch-chroot /mnt

passwd
#pacman -Sy --noconfirm archlinux-keyring

# time zone
ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
#hwclock --systohc

# locale
sed 's/^#en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen
locale-gen
cat > /etc/locale.conf << EOF
LANG=en_US.UTF-8
#LC_COLLATE=C
EOF

# disk
cat > /etc/fstab << EOF
/dev/mapper/root / ext4 rw,noatime,discard 0 1
UUID=$(findmnt --noheadings --output=UUID --target=/boot) /boot vfat rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro 0 2
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
options ip=:::::eth0:dhcp cryptdevice=UUID=$(lsblk --noheadings --inverse --output UUID /dev/mapper/root | sed --quiet 2p):root:allow-discards root=/dev/mapper/root rw
EOF
sed 's/block filesystems/keymap block encrypt filesystems/' -i /etc/mkinitcpio.conf
mkinitcpio --allpresets

# network
cat > /etc/hostname << EOF
arch
EOF
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
cat > /etc/systemd/network/20-wired.network << EOF
[Match]
Name=eth*
[Network]
DHCP=yes
EOF
systemctl enable systemd-networkd

# iptables & nftables
cat > /etc/iptables/iptables.rules << EOF
*filter
:INPUT ACCEPT [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
EOF
systemctl enable iptables
cat > /etc/iptables/ip6tables.rules << EOF
*filter
:INPUT ACCEPT [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
COMMIT
EOF
systemctl enable ip6tables
cat > /etc/nftables.conf << EOF

EOF
systemctl enable nftables

# ssh
cat >> /etc/ssh/sshd_config << EOF
#
Port 22
#AddressFamily inet
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr
MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com
ClientAliveInterval 15
EOF
systemctl enable sshd
mkdir -- "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys"
chmod -R go-rwx "$HOME/.ssh"

# ssh luks unlock
pacman -S --noconfirm mkinitcpio-netconf mkinitcpio-tinyssh mkinitcpio-utils
sed 's/block encrypt filesystems/block netconf tinyssh encryptssh filesystems/' -i /etc/mkinitcpio.conf
ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -C "" -N ""
ssh-keygen -y -f "$HOME/.ssh/id_ed25519" > /etc/tinyssh/root_key
mkinitcpio --allpresets

# add user
pacman -S --noconfirm sudo zsh-completions
USER1=user
useradd --create-home --shell /bin/zsh $USER1
passwd $USER1
cat > /etc/sudoers.d/$USER1 << EOF
$USER1 ALL=(ALL) ALL
EOF
```

## gui

```
# dm
pacman -S --noconfirm lxdm ttf-dejavu openbox
systemctl enable lxdm

# packages
pacman -S --noconfirm xorg-xrdb xorg-xset xorg-xsetroot
pacman -S --noconfirm xsecurelock xterm

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
mkdir -- "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys"
chmod -R go-rwx "$HOME/.ssh"

# dotfiles
sudo pacman -S --noconfirm git make
git clone https://github.com/akozlins/dotfiles .dotfiles
( cd .dotfiles && ./install.sh )

sudo pacman -S --noconfirm cmake gcc

# fbpanel
sudo pacman -S --noconfirm pkgconf gdk-pixbuf-xlib
( cd .dotfiles/opt && make fbpanel )

# far2l
sudo pacman -S --noconfirm patch m4 uchardet wxgtk2 spdlog xerces-c
( cd .dotfiles/opt && make far2l )

sudo pacman -S --noconfirm fakeroot
git clone https://aur.archlinux.org/yay.git "$HOME/yay"
( cd "$HOME/yay" && makepkg -s )
```

## packages

```
pacman -S --noconfirm htop mc tmux vim
pacman -S --noconfirm man-db man-pages pkgfile
pacman -S --noconfirm bind unbound
pacman -S --noconfirm borg gnu-netcat mtr ripgrep rsync socat
```

```
pacman -S --noconfirm gedit gedit-plugins libgit2-glib
pacman -S --noconfirm pcmanfm gvfs
```

- `dunst`
- `usbguard ssh-audit earlyoom`
