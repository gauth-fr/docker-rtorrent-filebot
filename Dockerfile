FROM crazymax/rtorrent-rutorrent:3.10-0.9.8-0.13.8

ARG FILEBOT_VER=4.9.3

ENV FILEBOT_LICENSE None

COPY rootfs /

RUN apk add --no-progress --no-cache \
    openjdk11 \
    openjdk11-jre \
    zlib-dev \
	libmediainfo \
	libmediainfo-dev \
	mkvtoolnix \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && apk update \
  && apk add --no-progress --no-cache chromaprint \
  # Install filebot
  && mkdir /filebot \
  && cd /filebot \
  && wget "https://get.filebot.net/filebot/FileBot_${FILEBOT_VER}/FileBot_${FILEBOT_VER}-portable.tar.xz" -O /filebot/filebot.tar.xz \
  && tar -xJf filebot.tar.xz \
  && rm -rf filebot.tar.xz \
  && ln -sf /usr/lib/libmediainfo.so /filebot/lib/Linux-x86_64/libmediainfo.so \
  && ln -sf /usr/lib/libzen.so /filebot/lib/Linux-x86_64/libzen.so \
  && rm -rf /filebot/lib/FreeBSD-amd64 /filebot/lib/Linux-armv7l /filebot/lib/Linux-i686 /filebot/lib/Linux-aarch64 \
  && rm -rf /var/cache/apk/
