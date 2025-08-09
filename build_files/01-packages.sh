#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

shopt -s nullglob

PKGS_TO_INSTALL=(
    @core
    @base-graphical
    @hardware-support
    @multimedia
    @networkmanager-submodules
    @printing
    @fonts

    flatpak
    gnome-shell
    ptyxis
    nautilus
    fedora-release-ostree-desktop

    avahi
    nss-mdns
    abrt
)

PKGS_TO_UNINSTALL=(
)

/ctx/pkg-helper.sh install "${PKGS_TO_INSTALL[@]}"
# /ctx/pkg-helper.sh uninstall "${PKGS_TO_UNINSTALL[@]}"

# MoreWaita Icons
echo "Installing MoreWaita"
git clone https://github.com/somepaulo/MoreWaita.git /tmp/MoreWaita >/dev/null 2>&1 && \
bash /tmp/MoreWaita/install.sh >/dev/null 2>&1

systemctl set-default graphical.target
echo "::endgroup::"
