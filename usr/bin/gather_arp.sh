#!/bin/sh

/usr/sbin/ip -4 neigh show dev br-lan nud reachable nud stale|cut -d" " -f 1,3,4|sort -n|column -t > /tmp/clients 
