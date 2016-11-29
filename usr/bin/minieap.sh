#!/bin/sh
# Launches 802.1x client

BASE_DIR=/usr
USERNAME=xxxx
PASSWORD=xxxx

WAN_DEVICE=`uci get network.wan.ifname`

killall minieap
# -a 1:  Broadcast addr=Ruijie
# -d 1:  Double auth with DHCP in between
# -b 3:  Run in background and store log in /var/log/minieap.log
# -x:  Don't re-authenticate if server asks us to go offline
#       Used when I want to log in with the same account elsewhere
# -c:   Asks udhcpc to renew lease and do those dirty IPv6 hacks
# --max-fail 1: Used to avoid failing continously
# --max-retries 1: Same as above
# --mac-dhcp-count 3: Give udhcpc more time to accomplish its task
# --module rjv3: Sure
$BASE_DIR/bin/minieap -n $WAN_DEVICE -u $USERNAME -p $PASSWORD -a 1 -d 1 -b 3 -x -c "/usr/bin/minieap_finish.sh" --max-fail 1 --max-retries 1 --max-dhcp-count 3 --module rjv3
