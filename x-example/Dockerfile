FROM matheuscastello/myx-ubuntu

# prepare and build your application
RUN apt-get -y update && apt-get install -y \
	mesa-utils \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# put your application to start on startx
RUN echo "glxgears -fullscreen" > ~/.xinitrc

CMD ["startx"]
