#

# /etc/udev/rules.d/10-lattice.rules
#SUBSYSTEM=="usb",ATTRS{idVendor}=="0403",ATTRS{idProduct}=="6010",GROUP="users",MODE="0666",SYMLINK+="ftdi-%n"
#SUBSYSTEM=="usb",ATTRS{idVendor}=="0403",ATTRS{idProduct}=="6010",RUN+="/bin/sh -c 'basename %p > /sys/bus/usb/drivers/ftdi_sio/unbind'"
