#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

curl -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
echo "Default=true" | tee -a /etc/flatpak/remotes.d/flathub.flatpakrepo > /dev/null
flatpak remote-add --if-not-exists --system flathub /etc/flatpak/remotes.d/flathub.flatpakrepo
flatpak remote-modify --system --enable flathub

# For avahi
getent group avahi >/dev/null || groupadd -r avahi
getent passwd avahi >/dev/null || useradd -r -g avahi -d /var/run/avahi-daemon -s /sbin/nologin \
    -c "Avahi mDNS daemon" avahi

# For abrt
getent group abrt >/dev/null || groupadd -r abrt
getent passwd abrt >/dev/null || useradd -r -g abrt -d /etc/abrt -s /sbin/nologin \
    -c "ABRT user" abrt

echo "::endgroup::"
