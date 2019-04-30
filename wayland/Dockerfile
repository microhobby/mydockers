FROM arm32v7/debian:buster-slim

# cross
COPY qemu-arm-static /usr/bin

# install wayland
RUN apt-get -y update && apt-get install -y \
	libegl1 \
	libglx-mesa0 \
	mesa-utils-extra \
	weston \
	udev \
	kmod \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

ENV UDEV 1

# up udev
COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
