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
  @gnome-desktop
  @workstation-product

  fedora-release-ostree-desktop
)

PKGS_TO_UNINSTALL=(
  gnome-classic-session
  gnome-tour
  gnome-extensions-app
  gnome-system-monitor
  gnome-initial-setup
  gnome-browser-connector
  gnome-shell-extension-background-logo
  gnome-shell-extension-apps-menu
)

/ctx/pkg-helper.sh install "${PKGS_TO_INSTALL[@]}"
/ctx/pkg-helper.sh uninstall "${PKGS_TO_UNINSTALL[@]}"

# MoreWaita Icons
echo "Installing MoreWaita"
git clone https://github.com/somepaulo/MoreWaita.git /tmp/MoreWaita >/dev/null 2>&1 && \
bash /tmp/MoreWaita/install.sh >/dev/null 2>&1

systemctl set-default graphical.target
echo "::endgroup::"
