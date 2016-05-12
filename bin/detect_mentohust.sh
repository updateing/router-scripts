#!/bin/sh
# Scripts run by Tasker on Android and lcd4linux
# Detects if mentohust is running.
# If not (same account logged in elsewhere), restart it.
# -n means dry-run. Just print result and don't restart.

BASE_DIR=/jffs
mentohust_process=`ps | grep mentohust | grep "[-]n"` # Confirm there is "-n"
if [ -z "$mentohust_process" ]; then
	# Restart mentohust when there is none
	if [ "x$1" == "x" ]; then
		$BASE_DIR/bin/start_mentohust.sh
		echo MentoHUST restarted.
	elif [ "x$1" == "xnoexec" ]; then
		echo MentoHUST is down.
	else
		echo USAGE: $0 \[noexec\]
		echo If noexec is given, MentoHUST won't be restarted when it's not running.
	fi
else
	echo MentoHUST is running.
fi
