FROM debian:buster

ARG snapcast_version=0.16.0
ENV HOST snapserver

RUN apt-get update                                                                                                          && \
  apt-get install -y wget ca-certificates dbus libapparmor1 libasound2 libasound2-data libavahi-client3                        \
  libavahi-common-data libavahi-common3 libdbus-1-3 libexpat1 libflac8 libogg0 libvorbis0a                                  && \
  wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapclient_${snapcast_version}_armhf.deb   && \
  dpkg -i snapclient_${snapcast_version}_armhf.deb                                                                          && \
  rm -rf /var/lib/apt/lists/*                                                                                               && \
  snapclient -v 

ENTRYPOINT ["/bin/bash", "-c", "snapclient -h $HOST"]
