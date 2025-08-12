#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

/ctx/helper/config-apply.sh

sed -i 's/^#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf
sed -i 's/^#LockLayering=false/LockLayering=true/' /etc/rpm-ostreed.conf
sed -i 's/#UserspaceHID.*/UserspaceHID=true/' /etc/bluetooth/input.conf

curl -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
echo "Default=true" | tee -a /etc/flatpak/remotes.d/flathub.flatpakrepo > /dev/null
flatpak remote-add --if-not-exists --system flathub /etc/flatpak/remotes.d/flathub.flatpakrepo
flatpak remote-modify --system --enable flathub

cat > /usr/lib/sysusers.d/sysusers-custom.conf << EOF
u avahi - "Avahi mDNS daemon" /var/run/avahi-daemon
g avahi - "Avahi mDNS daemon"

u abrt - "ABRT user" /etc/abrt
g abrt - "ABRT group"

u wsdd - "WSDD service user" /var/lib/wsdd
EOF

echo "::endgroup::"
