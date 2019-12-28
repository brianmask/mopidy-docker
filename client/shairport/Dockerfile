FROM debian:buster

COPY shair.sh /usr/local/bin/shair.sh

RUN apt-get update && apt-get upgrade -y                                                                               && \
  apt-get install -y build-essential git xmltoman autoconf automake libtool libpopt-dev libconfig-dev                     \ 
                     libasound2-dev avahi-daemon libavahi-client-dev libssl-dev libsoxr-dev                            && \
  cd /opt/                                                                                                             && \
  git clone https://github.com/mikebrady/shairport-sync.git                                                            && \
  cd shairport-sync                                                                                                    && \
  autoreconf -fi                                                                                                       && \
  ./configure --sysconfdir=/etc --with-alsa --with-soxr --with-avahi --with-ssl=openssl --with-metadata --with-pipe    && \  
  make && make install

COPY shairport-sync.conf /etc/shairport-sync.conf.sample

ENTRYPOINT ["/bin/bash", "/usr/local/bin/shair.sh"]
