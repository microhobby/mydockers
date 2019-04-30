FROM matheuscastello/myx

# install mono
RUN apt-get -y update && apt-get install -y \
	mono-complete \
	libmono-system-windows-forms4.0-cil \
	wget \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

CMD ["startx"]
