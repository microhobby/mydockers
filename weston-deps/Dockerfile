FROM arm32v7/debian:buster-slim

RUN apt-get -y update && apt-get install -y --no-install-recommends \
	udev \
	kmod \
	#libglx-mesa0 \
	#libegl1 \
	#libwayland-client0 \
	#libwayland-egl1 \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# copy calibration
COPY touch.rules /etc/udev/rules.d/

# wayland
ENV UDEV 1
# xorg
ENV DISPLAY=:0

# up udev
COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
