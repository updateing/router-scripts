#!/bin/sh

# Send unsolicited neighbor advertisement every minute
# to inform the upstream switch about our existence.
# Otherwise it will declare itself as the owner as
# this address. This is REALLY disgusting.
# This script replaces the dirty ip addr add / del trick (refresh6.sh)
# Better use with cron.
# F--- RJ

# ndsend is available in vzctl
NDSEND_BIN=/usr/bin/ndsend

# Advertise this address as well as WAN address. This should be all
# addresses in our DHCPv6 pool, but I don't want to mess with DHCPv6
# anymore. I was / am a Windows / Android user, you know it.
EXTRA_IPV6=2001:db8::1234

# Advertise enough times to make the dumb switch hear us
# (OT: It's so dumb that it advertises itself 64+ times with just one
# router solicitation)
ADVERTISE_REPEAT=5

# Use ndsend to advertise this address for $ADVERTISE_REPEAT times
# $1: advertise address
# $2: network interface
advertise() {
    for i in `seq 1 $ADVERTISE_REPEAT`; do
        echo "Advertising $1 on $2"
        $NDSEND_BIN $1 $2
        sleep 1
    done
}

# Do not use library functions since there is no wan6 (the reboot bug)
WAN_IFACE=`uci get network.wan.ifname`
WAN_IPV6_FULL=`ip -o -6 addr show scope global dev $WAN_IFACE|sed 's/  */ /g'|cut -d " " -f 4`
WAN_IPV6=${WAN_IPV6_FULL%/*}

# We just advertise addresses here. Let npd6 respond to later NSes.
advertise $WAN_IPV6 $WAN_IFACE
advertise $EXTRA_IPV6 $WAN_IFACE
