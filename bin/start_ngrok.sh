#!/bin/sh
# Why do we have a public IPv4 address but can not be reached outside of campus network?
BASE_DIR=/jffs
nohup $BASE_DIR/bin/ngrok -log-level=info -log=stdout -config=$BASE_DIR/etc/ngrok.yml start-all &

