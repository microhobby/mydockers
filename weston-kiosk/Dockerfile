FROM arm32v7/debian:buster-slim

RUN apt-get -y update && apt-get install -y --no-install-recommends \
	udev \
	kmod \
	weston \
	libegl1 \
	xwayland \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# copy calibration
COPY touch.rules /etc/udev/rules.d/
# copy config
COPY weston.ini /

ENV UDEV 1

# up udev
COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]

CMD [ "weston-launch", "--tty=/dev/tty7", "--user=root" ]
