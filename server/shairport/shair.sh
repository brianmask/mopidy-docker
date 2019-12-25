rm -rf /run
mkdir -p /run/dbus
dbus-uuidgen --ensure
dbus-daemon --system
avahi-daemon --daemonize --no-chroot
shairport-sync -m avahi