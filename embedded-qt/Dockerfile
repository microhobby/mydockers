FROM arm32v7/debian:buster-slim

# cross
COPY qemu-arm-static /usr/bin

# install deps
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
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# copy the sources
COPY qt-everywhere-src-5.12.1.tar.xz /

# untar sources and compile
RUN tar xvf qt-everywhere-src-5.12.1.tar.xz && \
	cd qt-everywhere-src-5.12.1 && \
	./configure -fast -skip qtwebengine -nomake examples -nomake tests -opensource -confirm-license && \
	make -j12 && \
	make install -j12 && \
	cd / && \
	rm -R qt-everywhere-src-5.12.1.tar.xz && \
	rm -R qt-everywhere-src-5.12.1
