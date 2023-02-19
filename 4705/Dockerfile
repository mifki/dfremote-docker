FROM ubuntu:20.04
MAINTAINER pronvit@me.com

# Install Dwarf Fortress dependencies and programs to download an unpack stuff
RUN apt-get update -y && apt-get install -y libncursesw5 libsdl-image1.2 libsdl-ttf2.0-0 libgtk2.0-0 libglu1-mesa openssl wget unzip && rm -rf /var/lib/apt/lists/*

# Download & Unpack DF+DFHack+DFRemote
RUN wget -q -O dfremote.zip http://assets.mifki.com.s3-website-us-east-1.amazonaws.com/dfupdate/dfremote-complete-4705-Linux.zip && unzip dfremote.zip -d /df_linux && rm dfremote.zip

ADD init.txt /df_linux/data/init/init.txt
ADD remote.txt /df_linux/data/init/remote.txt
RUN rm -f /df_linux/gamelog.txt ; ln -sf /dev/null /df_linux/gamelog.txt
RUN rm -f /df_linux/errorlog.txt ; ln -sf /dev/null /df_linux/errorlog.txt
RUN ln -sf /dev/null /df_linux/stdout.log
RUN ln -sf /dev/stderr /df_linux/stderr.log
RUN rm /df_linux/libs/libstdc++.so.6
RUN rm -rf /df_linux/dfhack-config

WORKDIR /df_linux

EXPOSE 1235/udp

RUN mkdir -p /df_linux/data/save
VOLUME /df_linux/data/save

ENV TERM=xterm
CMD LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./hack LD_PRELOAD=./hack/libdfhack.so /df_linux/libs/Dwarf_Fortress > /dev/null
