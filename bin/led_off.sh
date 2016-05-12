#!/bin/sh
# For Netgear R7000 only!
# Script to turn off all leds

gpio enable 2 # Power White
gpio enable 3 # Power Orange
gpio enable 8 # WAN Orange
gpio enable 9 # WAN White
killall blink; gpio enable 12 # 2.4G
gpio enable 13 # 5G
gpio disable 14 # WPS button
gpio disable 15 # WiFi button
gpio enable 17 # USB1
gpio enable 18 # USB2

# Switch LEDs
et robowr 0x0 0x18 0x1e0
et robowr 0x0 0x1a 0x1e0

