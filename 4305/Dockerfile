FROM ubuntu:16.04
MAINTAINER pronvit@me.com

# Install Dwarf Fortress dependencies
RUN apt-get update -y && apt-get install -y libsdl-image1.2 libsdl-ttf2.0-0 libgtk2.0-0 libglu1-mesa openssl

# Setup en_US.UTF-8 locale (so we can see _all_ DF's ASCII)
#ENV LANG en_US.UTF-8
#RUN apt-get -y install locales && locale-gen en_US.UTF-8

# Install wget (to download DF and DFHack)
RUN apt-get install -y wget unzip bzip2

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download & Unpack Dwarf Fortress
RUN wget -qO- http://www.bay12games.com/dwarves/df_43_05_linux.tar.bz2 | tar -xj -C /

# Download & Unpack DFHack+DFRemote
RUN wget -q -O dfremote.zip http://mifki.com/df/update/dfremote-full-4305-Linux.zip && unzip dfremote.zip -d /df_linux && rm dfremote.zip

ADD init.txt /df_linux/data/init/init.txt
ADD dfhack.init /df_linux/dfhack.init
RUN rm -f /df_linux/gamelog.txt ; ln -sf /dev/null /df_linux/gamelog.txt

WORKDIR /df_linux

EXPOSE 1235/udp

RUN mkdir -p /df_linux/data/save
VOLUME /df_linux/data/save

CMD /df_linux/dfhack

