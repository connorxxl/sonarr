FROM ubuntu:bionic

MAINTAINER connorxxl <christian.flaig@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xA236C58F409091A18ACA53CBEBFF6B99D9B78493 && \
    echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list && \
    apt-get update && \
    apt-get install -y nzbdrone mediainfo libcurl3 && \
    apt-get -y autoremove && \
    apt-get -y clean

RUN mkdir -p /config && \
    mkdir -p /volumes/complete && \
    mkdir -p /volumes/tvseries

EXPOSE 8989

VOLUME ["/config"]
VOLUME ["/volumes/complete"]
VOLUME ["/volumes/tvseries"]

WORKDIR /opt/NzbDrone

ENTRYPOINT ["mono", "/opt/NzbDrone/NzbDrone.exe"]
CMD [ "-nobrowser", "-data=/config" ]
