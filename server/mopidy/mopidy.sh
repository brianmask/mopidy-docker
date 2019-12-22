#!/bin/bash

# Copy config if it does not already exist
if [ ! -f /mopidy/conf/mopidy.conf ]; then
    cp /mopidy/.config/mopidy.conf.default /mopidy/conf/mopidy.conf
    
    # Replace env var values in config
    if [ -n "$SPOTIFY_USERNAME" ]; then
        sed -i "/\[spotify\]/,/\[.*\]/ s/username.*/username = ${SPOTIFY_USERNAME}/" /mopidy/conf/mopidy.conf
    fi
    if [ -n "$SPOTIFY_PASSWORD" ]; then
        sed -i "/\[spotify\]/,/\[.*\]/ s/password.*/password = ${SPOTIFY_PASSWORD}/" /mopidy/conf/mopidy.conf
    fi
    if [ -n "$SPOTIFY_CLIENT_ID" ]; then
        sed -i "/\[spotify\]/,/\[.*\]/ s/client_id.*/client_id = ${SPOTIFY_CLIENT_ID}/" /mopidy/conf/mopidy.conf
    fi
    if [ -n "$SPOTIFY_CLIENT_SECRET" ]; then
        sed -i "/\[spotify\]/,/\[.*\]/ s/client_secret.*/client_secret = ${SPOTIFY_CLIENT_SECRET}/" /mopidy/conf/mopidy.conf
    fi

    if [ -n "$GMUSIC_USERNAME" ]; then
        sed -i "/\[gmusic\]/,/\[.*\]/ s/username.*/username = ${GMUSIC_USERNAME}/" /mopidy/conf/mopidy.conf
    fi
    if [ -n "$GMUSIC_USERNAME" ]; then
        sed -i "/\[gmusic\]/,/\[.*\]/ s/password.*/password = ${GMUSIC_PASSWORD}/" /mopidy/conf/mopidy.conf
    fi

    if [ -n "$LASTFM_USERNAME" ]; then
	sed -i "/\[scrobbler\]/,/\[.*\]/ s/username.*/username = ${LASTFM_USERNAME}/" /mopidy/conf/mopidy.conf
    fi

    if [ -n "$LASTFM_USERNAME" ]; then
	sed -i "/\[scrobbler\]/,/\[.*\]/ s/password.*/password = ${LASTFM_PASSWORD}/" /mopidy/conf/mopidy.conf
    fi
fi

if [ ${APT_PACKAGES:+x} ]; then
    echo "-- INSTALLING APT PACKAGES $APT_PACKAGES --"
    apt install -y $APT_PACKAGES
fi
if  [ ${PIP_PACKAGES:+x} ]; then
    echo "-- INSTALLING PIP PACKAGES $PIP_PACKAGES --"
    pip install $PIP_PACKAGES
fi
if [ ${UPDATE:+x} ]; then
    echo "-- UPDATING ALL PACKAGES --"
    apt-get update
    apt-get upgrade -y
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U # Upgrade all pip packages
fi

exec /usr/bin/mopidy --config /mopidy/conf/mopidy.conf
