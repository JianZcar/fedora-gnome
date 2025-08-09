#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

shopt -s nullglob

PKGS_TO_INSTALL=(
    @base-graphical
    @hardware-support
    @multimedia
    @fonts

    flatpak
    gnome-shell
    gnome-software
    ptyxis
    nautilus
    morewaita-icon-theme
    fedora-release-ostree-desktop
)

PKGS_TO_UNINSTALL=(
    gnome-classic-session
    gnome-tour
    gnome-initial-setup
)

/ctx/pkg-helper.sh install "${PKGS_TO_INSTALL[@]}"
/ctx/pkg-helper.sh uninstall "${PKGS_TO_UNINSTALL[@]}"

systemctl set-default graphical.target
echo "::endgroup::"
