#!/bin/sh
# Launches 802.1x client

BASE_DIR=/jffs
USERNAME=xxx
PASSWORD=xxx

# Same WAN detection as start.sh
WAN_DEVICE=`nvram get wan_ifname`

killall mentohust
# Long options (--max-fail) require new version of MentoHUST
# -a1:  Broadcast addr=Ruijie
# -d2:  DHCP=Perform after authenticating
# -b3:  Run in background and store log in /tmp/mentohust.log
# -x0:  Don't re-authenticate if server asks us to go offline
#       Used when I want to log in with the same account elsewhere
# -r99: Retry after 99 seconds if authentication fails
#       Normally, this won't fail unless something REALLY BAD happens,
#       so we need to wait longer
# -c:   Asks udhcpc to renew lease since it couldn't get one before
#       this succeeds
# --max-fail 1: Same as -r99. Used to avoid failing continously
$BASE_DIR/bin/mentohust -n$WAN_DEVICE -u$USERNAME -p$PASSWORD -a1 -d2 -b3 -x0 -r99 -c"kill -USR1 `cat /var/run/udhcpc-wan.pid`" --max-fail 1
