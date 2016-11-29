#!/bin/sh
# Scripts run by Tasker on Android and lcd4linux
# Detects if minieap is running.
# If not (same account logged in elsewhere), restart it.
# Parameter "noexec" means dry-run. Just print result and don't restart.

BASE_DIR=/usr
minieap_process=`pgrep minieap`
if [ -z "$minieap_process" ]; then
	# Restart minieap when there is none
	if [ "x$1" == "x" ]; then
		$BASE_DIR/bin/minieap.sh
		echo MiniEAP restarted.
	elif [ "x$1" == "xnoexec" ]; then
		echo MiniEAP is down.
	else
		echo USAGE: $0 \[noexec\]
		echo If noexec is given, MiniEAP won't be restarted when it's not running.
	fi
else
	echo MiniEAP is running.
fi
