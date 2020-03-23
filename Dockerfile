FROM ubuntu:bionic

MAINTAINER connorxxl <christian.flaig@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Zurich

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8 && \
    echo "deb https://apt.sonarr.tv/ubuntu bionic main" | tee /etc/apt/sources.list.d/sonarr.list && \
    apt-get update && \
    apt-get install -y nzbdrone mediainfo libcurl3 tzdata && \
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
