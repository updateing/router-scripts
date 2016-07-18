#!/bin/sh

export PATH=/jffs/bin:/jffs/scripts:/usr/bin:/sbin:/bin:/usr/sbin
export LD_LIBRARY_PATH=/jffs/lib:/tmp/lib
[ -x /jffs/bin/login.sh ] && /jffs/bin/login.sh "$@"
/bin/sh "$@"
