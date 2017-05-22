FROM ubuntu:14.04
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

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download & Unpack Dwarf Fortress
RUN wget --no-check-certificate -qO- http://www.bay12games.com/dwarves/df_40_24_linux.tar.bz2 | tar -xj -C /

# Download & Unpack DFHack+DFRemote
RUN wget --no-check-certificate -q -O dfremote.zip http://mifki.com/df/update/dfremote-full-4024-Linux.zip && unzip dfremote.zip -d /df_linux && rm dfremote.zip

ADD init.txt /df_linux/data/init/init.txt
ADD dfhack.init /df_linux/dfhack.init
RUN rm /df_linux/gamelog.txt ; ln -sf /dev/null /df_linux/gamelog.txt

WORKDIR /df_linux

EXPOSE 1235/udp

RUN mkdir -p /df_linux/data/save
VOLUME /df_linux/data/save

CMD /df_linux/dfhack

