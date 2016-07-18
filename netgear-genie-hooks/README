Netgear Genie Hooks
===

This is my customization of Network Genie firmwares, based on Xiaobao's custom firmware on Koolshare.

###Features

1. Event-driven scripts
2. Custom dnsmasq configuration

Note: you need to write scripts using the hooks. The hooks themselves do not introduce any new feature.

###Usage

1. Unpack original firmware

1.a. Use an hex editor to remove the header of CHK file (remove everything before the TRX magic "HDR0").

1.b `untrx xxx.trx`

1.c Now you get `xxx.trx.part[0-3]`. Part0 is TRX header and can be ignored. Part1 is vmlinuz. Part2 is rootfs (squashfs with xz compression).

1.d `unsquashfs xxx.trx.part2`

2. Placing the hooks

```
cd squashfs-root
mv sbin/acos_service usr/sbin/acos_service
mv usr/bin/dnsmasq usr/bin/dnsmasq.bin
cp -R /path/to/this/rootfs .
```

Now you can place your hooks in `/hooks/pre` and `/hooks/post`, or do some other binary tweaks.

3. Repack the firmware

```
cd ..
mksquashfs squashfs-root rootfs.fs -comp xz
touch empty
trx -o linux.trx xxx.trx.part1 empty rootfs.fs empty
packet -k linux.trx -f empty -b compatible.txt -ok kernel -oall all -or rootfs_stub -i ambitCfg.h
```

`trx` and `packet` is in `Netgear_GPL_Archive/tools`
`compatible.txt` is in `Netgear_GPL_Archive/src/router/arm-uclibc/compatible_xxxx.txt`
`ambitCfg.h` is in `Netgear_GPL_Archive/ap/acos/include`

Note: `packet` takes only relative paths as its parameter.

4. Update the router with all.chk (Web) or linux.trx (CFE).

###Hooks Description

`acos_service` seems like a state collector, and it will be executed when a range of events happen.

We wrap this executable in our own script, and the events will be available to us as well.

**There are two types of hooks:**

1. Pre-hook and Precondition

Pre-hooks and Preconditions are called before the event is dispatched to `acos_service`. Pre-hooks are in `pre/` directories, and preconditions are in `precond/` directories.

Exit code of precondition hooks will be checked. If it fails, the event will not be dispatched to `acos_service`. Exit code of pre-hooks will not be checked.

Preconditions are only availble in `jffs/`, while pre-hooks are only available in `rootfs/`.

2. Post-hook

Post-hooks are called after the event is sent to `acos_service`. These hooks are in `post/` directories, and available in both `rootfs/` and `jffs/`. Exit code is not checked.

**There are two locations where hooks can be placed:**

1. `rootfs/hooks/pre` and `rootfs/hooks/post`

These directories are located in the read-only squashfs, suitable for commonly used services such as SSH.

2. `jffs/scripts/precond` and `jffs/scripts/post`

These directories are located in /jffs (linked to /tmp/media/nand), suitable for user-defined services or personal scripts, such as manual IPv6 configuration.

**Rules of file names:**

There are two types of event notification, and the naming rules of corresponding hooks are different:

1. `/sbin/acos_service start`, `/sbin/acos_service stop` etc

`acos_service` is invoked as is, with event name as parameter.

If you want to hook this kind of events, you can create a script named `acos_service_${EVENT}`. *This script will receive the same parameters as original invocation.* For example, if you want to post-hook `/sbin/acos_service restart_wan` in jffs, you create `/jffs/scripts/post/acos_service_restart_wan`, and it will be called as `/jffs/scripts/post/acos_service_restart_wan restart_wan`.

2. `/sbin/autoconfig_wan_up`, `/tmp/udhcpc bound` etc

`acos_service` is linked to another name, and event is the program name itself or the first parameter.

If you want to hook this kind of events, you can create a script named `${EXE_NAME}`. This script will receive the same parameters as original invocation. For example, if you want to do something before `/tmp/udhcpc bound` in jffs, you create `/jffs/scripts/precond/udhcpc` (if you don't want to interrupt the invocation, make sure this script returns 0). It will be called as `/jffs/scripts/precond/udhcpc bound`.

Note: other invocation of `/tmp/udhcpc` will also launch your script. You may check the parameters before taking action.

###Custom dnsmasq configuration

Dnsmasq executable is also wrapped.

If directory `/jffs/configs/dnsmasq.d` exists, the wrapper will add `--conf-dir=/jffs/configs/dnsmasq.d` automatically to the command line.

Note: the dnsmasq binary in Netgear firmware is terribly trimmed, with nearly no feature (except for DNS) available. The `--conf-dir` is not supported, either. If you want to use this feature, remember to update the binary, otherwise dnsmasq will not start with `/jffs/configs/dnsmasq.d` present.

###Misc info

Each invocation of `acos_service` is logged in `/tmp/acos_service_call_log`. Output of hook scripts will be logged too.

There are some known events you can hook:

1. `acos_service start` (post-hook only, hook name `acos_service_start`): jffs will be ready at this time
2. `udhcpc bound` (hook name `udhcpc`): IP address obtained for the time time
3. `udhcpc renew` (hook name `udhcpc`)
4. `autoconfig_wan_up` (hook name `autoconfig_wan_up`): IPv6 auto-configuration finished
