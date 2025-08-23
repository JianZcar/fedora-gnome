#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

shopt -s nullglob

PKGS_TO_INSTALL=(
    @base-graphical
    @hardware-support
    @multimedia
    @fonts

    zram-generator-defaults

    git
    yq
    unzip
    
    fedora-release-ostree-desktop
    flatpak
    
    gnome-shell
    gnome-software
    ptyxis
    nautilus
    morewaita-icon-theme
    adw-gtk3-theme
    
    nerd-fonts
    wl-copy
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

dnf5 -y install "${PKGS_TO_INSTALL[@]}"
dnf5 -y remove "${PKGS_TO_UNINSTALL[@]}"

git clone https://github.com/JianZcar/zena-shell-gnome.git /usr/share/gnome-shell/extensions/zena-shell@jianzcar.github \
  && rm -rf /usr/share/gnome-shell/extensions/zena-shell@jianzcar.github/.git

for ext in "${GNOME_EXTS_TO_INSTALL[@]}"; do
  /ctx/helper/install-gnome-extension.sh "$ext"
done

systemctl set-default graphical.target
echo "::endgroup::"
