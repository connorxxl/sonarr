FROM ubuntu:bionic

MAINTAINER connorxxl <christian.flaig@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Zurich

RUN apt update

RUN apt install -y gnupg ca-certificates && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt update

RUN apt install -y wget

RUN wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-12_all.deb && \
    dpkg -i repo-mediaarea_1.0-12_all.deb && \
    apt-get update



RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8 && \
    echo "deb https://apt.sonarr.tv/ubuntu bionic main" | tee /etc/apt/sources.list.d/sonarr.list && \
    apt-get update && \
    apt-get install -y sonarr mediainfo libcurl3 tzdata && \
    apt-get -y autoremove && \
    apt-get -y clean

RUN mkdir -p /config && \
    mkdir -p /volumes/complete && \
    mkdir -p /volumes/tvseries

EXPOSE 8989

VOLUME ["/config"]
VOLUME ["/volumes/complete"]
VOLUME ["/volumes/tvseries"]

WORKDIR /var/lib/sonarr

ENTRYPOINT ["mono", "/usr/lib/sonarr/bin/Sonarr.exe"]
CMD [ "-nobrowser", "-data=/config" ]
