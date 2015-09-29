FROM ubuntu:trusty

MAINTAINER connorxxl <christian.flaig@gmail.com>

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC  && \
    echo "deb http://apt.sonarr.tv/ develop main" | tee -a /etc/apt/sources.list \
    apt-get update && \
    apt-get install -y nzbdrone mediainfo && \
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
