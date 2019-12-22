FROM debian:buster

COPY mopidy.sh /usr/local/bin/mopidy.sh
COPY mopidy.conf.default /mopidy/.config/mopidy.conf.default

RUN apt-get update && apt-get upgrade -y                                                && \  
  apt-get install -y python python-pip wget gnupg2 vim                                  && \
  wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add -                        && \
  wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list     && \
  apt-get update                                                                        && \
  apt-get install -y mopidy mopidy-spotify mopidy-spotify-tunigo mopidy-scrobbler          \
                     mopidy-local-sqlite                                                && \
  rm -rf /var/lib/apt/lists/*                                                           && \
  pip install Mopidy-Iris Mopidy-Local-Images Mopidy-Material-Webclient Mopidy-Mobile      \
              Mopidy-Moped Mopidy-Mopify Mopidy-MusicBox-Webclient Mopidy-Party            \
              Mopidy-API-Explorer Mopidy-Youtube youtube-dl                             && \
  mkdir /mopidy/media /mopidy/data /mopidy/conf                                         && \
  chmod a+rx /usr/local/bin/mopidy.sh                                                   && \
  groupadd -o --gid 100 -r mopidy                                                       && \
  usermod -a -G mopidy mopidy                                                           && \
  chown -R mopidy:mopidy /mopidy                                                         

USER mopidy

WORKDIR /mopidy

ENTRYPOINT ["/usr/local/bin/mopidy.sh"]
