#!/bin/bash

# Copy config if it does not already exist
if [ ! -f /etc/shairport-sync.conf ]; then
    cp /etc/shairport-sync.conf.sample /etc/shairport-sync.conf
    
    # Replace env var values in config
    if [ -n "$SHAIRPORT_HOST" ]; then
        sed -i "/name.*/name = \"${SHAIRPORT_HOST}\";/" /etc/shairport-sync.conf
    fi
fi

rm -rf /run
mkdir -p /run/dbus
dbus-uuidgen --ensure
dbus-daemon --system
avahi-daemon --daemonize --no-chroot
shairport-sync -m avahi