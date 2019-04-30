FROM matheuscastello/myx

# install chromium
RUN apt-get -y update && apt-get install -y \
	chromium \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# no stand by and calibration for touch
COPY xorg.conf /etc/X11/

# up udev and startx
COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
