#!/bin/bash

# build
docker build -f Dockerfile . -t matheuscastello/myx

# pull to docker hub
docker login
docker push matheuscastello/

# delete all containers
docker rm -vf $(docker ps -a -q)

# delete all untagged
docker rmi $(docker images -q --filter "dangling=true")

# delete all images
docker rmi -f $(docker images -a -q)

# run torizon with dbus and dev share
docker run -d -it --privileged -v /var/run/dbus:/var/run/dbus \
	-v /dev:/dev torizon/debian-lxde:buster startx

# run override entrypoint
docker run --name example --entrypoint "bash" -it --privileged -v /var/run/dbus:/var/run/dbus \
-v /dev:/dev matheuscastello/myx-example

# run an raw debian
docker run --name charts -d -it --privileged -v /var/run/dbus:/var/run/dbus \
-v /dev:/dev matheuscastello/myx-qt-chart startx

# run the x
docker run --name osci -d -it --restart unless-stopped --privileged -v /var/run/dbus:/var/run/dbus \
-v /dev:/dev matheuscastello/myx-qt-chart startx

# run the x with debug
docker run --name myx -it --privileged -v /var/run/dbus:/var/run/dbus \
-v /dev:/dev matheuscastello/myx-ubuntu bash

# run the x with debug
docker run --name mono -d -it --privileged -v /var/run/dbus:/var/run/dbus \
-v /dev:/dev -v /home/torizon:/torizon matheuscastello/torizonmono startx

# run dotnet
docker run --name dotnet -d -it --privileged -v /var/run/dbus:/var/run/dbus \
-v /dev:/dev -v /home/torizon:/torizon -v /sys:/sys microsoft/dotnet

# run dotnet with mono
docker run --name mono -it --privileged -v /var/run/dbus:/var/run/dbus \
-v /dev:/dev -v /home/torizon:/torizon -v /sys:/sys matheuscastello/myx-mono-example startx

# only run
docker run --name ubuntu -d -it matheuscastello/myx-ubuntu

# flat
docker export myx | docker import - matheuscastello/myx-ubuntu

# enable binfmt
sudo apt install qemu-user-static qemu-user-binfmt
sudo modprobe binfmt_misc
git clone https://github.com/computermouth/qemu-static-conf.git
sudo mkdir -p /lib/binfmt.d
sudo cp qemu-static-conf/*.conf /lib/binfmt.d
sudo systemctl restart systemd-binfmt.service
