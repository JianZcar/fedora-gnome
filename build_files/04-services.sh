#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

services=(
    podman.socket
)

disable_services=(
)

mask_services=(
    systemd-remount-fs.service
    flatpak-add-fedora-repos.service
    bootc-fetch-apply-updates.service
    bootc-fetch-apply-updates.timer
    rpm-ostree-countme.service
    rpm-ostree-countme.timer
    logrotate.service
    logrotate.timer
)

user_services=(
)

systemctl enable "${services[@]}"
# systemctl disable "${disable_services[@]}"
systemctl mask "${mask_services[@]}"
# systemctl --global enable "${user_services[@]}"

echo "::endgroup::"
