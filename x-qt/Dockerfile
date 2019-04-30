FROM matheuscastello/qt-build:alpha as build

# cross
COPY qemu-arm-static /usr/bin

FROM arm32v7/ubuntu:18.04 as release

# cross
COPY qemu-arm-static /usr/bin 

# get arch deps
COPY --from=build /usr/lib/arm-linux-gnueabihf/ /usr/lib/arm-linux-gnueabihf/

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

# get QT
COPY --from=build /usr/local/Qt-5.12.1/lib/ /usr/local/Qt-5.12.1/lib/
COPY --from=build /usr/local/Qt-5.12.1/plugins/ /usr/local/Qt-5.12.1/plugins/
COPY --from=build /usr/local/Qt-5.12.1/qml/ /usr/local/Qt-5.12.1/qml/
# set plugins
RUN ln -sf /usr/local/Qt-5.12.1/plugins/platforms/ /usr/bin/

# no stand by and calibration for touch
COPY xorg.conf /etc/X11/

# Add tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-armhf /bin/tini
RUN chmod +x /bin/tini

# up udev
COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
