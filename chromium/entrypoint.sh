#!/bin/bash

# up udev
/lib/systemd/./systemd-udevd &
udevadm trigger --type=subsystems --action=add &
udevadm trigger --type=devices --action=add &

# trap the stop signal then send SIGTERM to user processes
trap signal_handler SIGRTMIN+3 SIGTERM

# exec docker CMD
# config x to start chromium
echo "chromium --start-fullscreen --no-sandbox --test-type $1" > ~/.xinitrc
export DISPLAY=:0

# echo error message, when executable file doesn't exist.
if [ $? == '0' ]; then
	shift
	tini -sg -- startx &
	pid=$!
	wait "$pid"
else
	echo "Command not found: $1"
	exit 1
fi
