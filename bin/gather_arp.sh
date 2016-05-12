#!/bin/sh
# Run by lcd4linux, look for all active clients in LAN in ARP table
arp -i br0 | grep -v incomplete | cut -d " " -f 1,2,4 | sed 's/[()]//g' | sort -k 4,4n -t . | /jffs/bin/column -t > /tmp/clients
