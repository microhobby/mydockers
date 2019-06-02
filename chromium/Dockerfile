FROM matheuscastello/weston-deps

# install chromium
RUN apt-get -y update && apt-get install -y \
	chromium \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# cmd to entrypoint
ENV APP="chromium"
ENV APPARGS="--no-sandbox --test-type --start-fullscreen"

# cmd as argument
CMD [ "www.toradex.com/pt-br/operating-systems/torizon" ]
