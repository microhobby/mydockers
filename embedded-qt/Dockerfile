FROM arm32v7/ubuntu:18.04

# cross
COPY qemu-arm-static /usr/bin

# enable sources URI
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list

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
	libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev \
	&& apt-get build-dep -y qt5-default \
	&& apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# copy the sources
COPY qt-everywhere-src-5.12.1.tar.xz /tmp

# untar sources and compile
RUN cd /tmp && \
	tar xvf qt-everywhere-src-5.12.1.tar.xz && rm qt-everywhere-src-5.12.1.tar.xz && \
	cd qt-everywhere-src-5.12.1 && \
	./configure -skip qtwebengine -nomake tests -nomake examples -xcb -qt-xcb -opensource -confirm-license && \
	make -j12 && \
	make install -j12 && \
	PATH=/usr/local/Qt-5.12.1/bin:$PATH && \
	export PATH && \
	cd / && rm -R tmp/
