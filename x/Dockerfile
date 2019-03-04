FROM arm32v7/debian:buster-slim

# cross
COPY qemu-arm-static /usr/bin

# install x
RUN apt-get -y update && apt-get install -y \
	udev \
	x11-xkb-utils \
    	xkb-data \
	xserver-xorg-core \
    	xinit \
	xserver-xorg-input-libinput \
	xserver-xorg-input-evdev \
	xserver-xorg-input-mouse \
	xserver-xorg-input-kbd \
	xserver-xorg-video-fbdev \
	x11-utils \
    	xfonts-base \
	dbus-x11 \
	tini \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# up udev
COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
