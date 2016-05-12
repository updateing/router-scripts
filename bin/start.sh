#!/bin/sh
# Script running at boot process
# This script starts IPv6 services and RJ 802.1x authentiacating

# Default to vlan2, but this may change when NAT accel is off.
LAN_DEVICE=br0
BASE_DIR=/jffs
WAN_DEVICE=vlan2
vlan2_stat=`ip link show | grep vlan2 | grep -v DOWN`
if [ -z "$vlan2_stat" ]; then
	# No VLAN2, WAN is eth0
	WAN_DEVICE=eth0
else
	WAN_DEVICE=vlan2
fi

# Sometimes I need to run this script again to restart services
killall radvd
killall ndppd

# Following lines are not required in Tomato
#ip -6 addr add 2001:xxx::xxx/112 dev $LAN_DEVICE
#echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
#echo 0 > /proc/sys/net/ipv6/conf/$WAN_DEVICE/forwarding
#echo 2 > /proc/sys/net/ipv6/conf/$WAN_DEVICE/accept_ra

# ip6tables should be in firewall-start
$BASE_DIR/bin/radvd -C $BASE_DIR/etc/radvd.conf
$BASE_DIR/bin/ndppd -c $BASE_DIR/etc/ndppd.conf -d

$BASE_DIR/bin/start_lcd.sh

# Wait for campus network services to be up
# Power on at 6:00, authenticating services up at several minutes later
sleep 600
$BASE_DIR/bin/start_mentohust.sh
