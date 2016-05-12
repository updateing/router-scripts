#!/bin/sh
BASE_DIR=/jffs
nohup $BASE_DIR/bin/ngrok -log-level=info -log=/tmp/ngrok.log -config=$BASE_DIR/etc/ngrok.yml start-all &

