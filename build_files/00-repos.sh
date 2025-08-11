#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -euxo pipefail

# Create directory
mkdir -p /var/roothome

dnf5 -y install dnf5-plugins

COPRS=(
    trixieua/morewaita-icon-theme
    che/nerd-fonts
)

for COPR in "${COPRS[@]}"; do
    echo "Enabling copr: $COPR"
    dnf5 -y copr enable "$COPR"
done

# Install RPMFusion repos
dnf5 -y install \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
