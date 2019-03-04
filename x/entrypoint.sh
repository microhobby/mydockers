#!/bin/bash

# up udev
/lib/systemd/./systemd-udevd &
udevadm trigger --type=subsystems --action=add &
udevadm trigger --type=devices --action=add &

# trap the stop signal then send SIGTERM to user processes
trap signal_handler SIGRTMIN+3 SIGTERM

# exec docker CMD
CMD=$(which "$1")
# echo error message, when executable file doesn't exist.
if [ $? == '0' ]; then
	shift
	tini -sg -- "$CMD" "$@" &
	pid=$!
	wait "$pid"
else
	echo "Command not found: $1"
	exit 1
fi
