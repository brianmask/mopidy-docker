FROM debian:buster

ARG snapcast_version=0.16.0
ENV STREAM_NAME=Snapserver

RUN apt-get update && apt-get upgrade -y                                                                                   && \
  apt-get install -y wget dbus libapparmor1 libavahi-client3 libavahi-common-data libavahi-common3                            \  
                     libdbus-1-3 libexpat1 libflac8 libogg0 libvorbis0a libvorbisenc2                                      && \
  wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}_amd64.deb  && \
  dpkg -i snapserver_${snapcast_version}_amd64.deb                                                                         && \  
  rm -rf /var/lib/apt/lists/*                                                                                              && \
  groupadd -o --gid 100 -r snapserver                                                                                      && \
  useradd  -g snapserver -ms /bin/bash snapserver                                                                          && \
  snapserver -v

USER snapserver

COPY snapserver.conf /etc/default/snapserver

EXPOSE 1704 1705 1780

ENTRYPOINT ["/bin/bash","-c","source /etc/default/snapserver && snapserver $SNAPSERVER_OPTS"]
