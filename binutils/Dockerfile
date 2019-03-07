FROM arm32v7/ubuntu:18.04

# cross
COPY qemu-arm-static /usr/bin

# install build deps
RUN apt-get -y update && apt-get install -y \
	xz-utils \
	python \
	libc6 \
	libc6-dev \
	binutils \
	make \
	libncurses5-dev \
	gcc g++ \
	git \
	bc \
	kpartx \
	u-boot-tools \
	libssl-dev \
	device-tree-compiler \
	libudev1 libudev-dev \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# done
CMD [ "bash" ]
