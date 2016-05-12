#!/bin/sh
# Loads lcd4linux
# -n means do not wait for device probing

BASE_DIR=/jffs

if [ "x$1" != "x-n" ]; then
	# Wait for device probing
	sleep 15
fi

# These drivers access the digital frame exclusively, remove them
# Only needed in Merlin
rmmod option
rmmod usb_wwan
rmmod usbserial

killall lcd4linux
# Sometimes the DPF won't react so fast
sleep 2
$BASE_DIR/bin/lcd4linux -q -f $BASE_DIR/etc/vertical-router.conf


