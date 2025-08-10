#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

shopt -s nullglob

PKGS_TO_INSTALL=(
    @base-graphical
    @hardware-support
    @multimedia
    @fonts

    git
    unzip
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

GNOME_EXTS_TO_INSTALL=(
    accent-directories@taiwbi.com
    appindicatorsupport@rgcjonas.gmail.com
    blur-my-shell@aunetx
    caffeine@patapon.info
    disable-workspace-switcher-overlay@cleardevice
    gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com
    hotedge@jonathan.jdoda.ca
    ideapad@laurento.frittella
    just-perfection-desktop@just-perfection
    splashindicator@ochi12.github.com
    window-centering@hnjjhmtr27
)

/ctx/helper/pkg-ctl.sh install "${PKGS_TO_INSTALL[@]}"
/ctx/helper/pkg-ctl.sh uninstall "${PKGS_TO_UNINSTALL[@]}"

git clone https://github.com/JianZcar/light-shell-plus.git /usr/share/gnome-shell/extensions/light-shell-plus@jianzcar.github \
  && rm -rf /usr/share/gnome-shell/extensions/light-shell-plus@jianzcar.github/.git
git clone https://github.com/JianZcar/peek-top-bar.git /usr/share/gnome-shell/extensions/peek-top-bar@jianzcar.github \
  && rm -rf /usr/share/gnome-shell/extensions/peek-top-bar@jianzcar.github/.git
git clone https://github.com/JianZcar/static-bg.git /usr/share/gnome-shell/extensions/static-bg@jianzcar.github \
  && rm -rf /usr/share/gnome-shell/extensions/static-bg@jianzcar.github/.git

for ext in "${GNOME_EXTS_TO_INSTALL[@]}"; do
  /ctx/helper/install-gnome-extension.sh "$ext"
done

systemctl set-default graphical.target
echo "::endgroup::"
