#!/bin/sh
# For Netgear R7000 only!
# Script to turn on all leds

gpio disable 2 # Power White On
gpio enable 3 # Power Orange Off

$WAN_IFACE=`nvram get wan_ifname`
if [ -z "`ip addr show $WAN_IFACE | grep inet | grep -v inet6`" ]; then
    # We have no IPv4 address on WAN
    gpio disable 8 # WAN Orange On
    gpio enable 9 # WAN White Off

else
    gpio enable 8 # WAN Orange Off
    gpio disable 9 # WAN White On
fi

# blink will control the GPIOs
blink eth1 wlan 20 8192
blink eth2 5g 20 8192

# Switch LEDs
et robowr 0x0 0x18 0x1ff
et robowr 0x0 0x1a 0x1ff

# Don't touch USB1/2 and the buttons
