FROM arm32v7/ubuntu:18.04

# cross
COPY qemu-arm-static /usr/bin

# install x
RUN apt-get -y update && apt-get install -y --no-install-recommends \
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
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# Add tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-armhf /bin/tini
RUN chmod +x /bin/tini

# no stand by and calibration for touch
COPY xorg.conf /etc/X11/

# up udev
COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
