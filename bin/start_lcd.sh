#!/bin/sh
# Loads lcd4linux

BASE_DIR=/jffs

if [ "x$1" != "x-n" ]; then
	# Wait for driver probing finish
	sleep 15
fi

# These drivers ccupied the digital frame
# Only needed in Merlin
rmmod option
rmmod usb_wwan
rmmod usbserial

killall lcd4linux
# Sometimes the DPF won't react so fast
sleep 2
$BASE_DIR/bin/lcd4linux -q -f $BASE_DIR/etc/vertical-router.conf


