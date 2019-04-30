FROM arm32v7/ubuntu:18.04

# cross
COPY qemu-arm-static /usr/bin

# install initial deps
RUN apt-get -y update && apt-get install -y \
	libc6 \
	libc6-dev \
	binutils \
	make \
	cmake \
	clang \
	gcc g++ \
	git \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
