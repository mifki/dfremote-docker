FROM ubuntu:14.10
MAINTAINER pronvit@me.com

# Install Dwarf Fortress dependencies
# 64 bit linux, but DF requires 32 bit libraries
RUN dpkg --add-architecture i386 && apt-get update -y && apt-get install -y \
    libsdl-image1.2:i386 libsdl-ttf2.0-0:i386 libgtk2.0-0:i386 libglu1-mesa:i386 openssl:i386

# Setup en_US.UTF-8 locale (so we can see _all_ DF's ASCII)
#ENV LANG en_US.UTF-8
#RUN apt-get -y install locales && locale-gen en_US.UTF-8

# Install wget (to download DF and DFHack)
RUN apt-get install -y wget unzip

# Download & Unpack Dwarf Fortress
RUN wget --no-check-certificate -qO- http://www.bay12games.com/dwarves/df_40_24_linux.tar.bz2 | tar -xj -C / && rm /df_linux/libs/libstdc++.so.6

# Download & Unpack DFHack
RUN wget --no-check-certificate -qO- https://github.com/DFHack/dfhack/releases/download/0.40.24-r3/dfhack-0.40.24-r3-Linux-gcc-4.5-no-stonesense.tar.bz2 | tar -xj -C /df_linux

RUN wget -q http://mifki.com/df/update/dfremote-updater.zip && unzip -j -d /df_linux/hack/plugins dfremote-updater.zip 0.40.24-r3/linux/* && rm dfremote-updater.zip
RUN wget -q http://mifki.com/df/update/dfremote-latest.zip && mkdir t && unzip -d t dfremote-latest.zip && mv t/0.40.24-r3/linux/* /df_linux/hack/plugins/ && mv t/remote /df_linux/hack/lua/ && rm -rf t && rm dfremote-latest.zip

ADD init.txt /df_linux/data/init/init.txt
ADD dfhack.init /df_linux/dfhack.init

WORKDIR /df_linux

EXPOSE 1235/udp

RUN mkdir /df_linux/data/save
VOLUME /df_linux/data/save

CMD /df_linux/dfhack

