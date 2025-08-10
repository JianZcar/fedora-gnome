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
)

user_services=(
)

for service in "${services[@]}"; do
  systemctl enable "$service"
done

for service in "${disable_services[@]}"; do
  systemctl disable "$service"
done

for service in "${mask_services[@]}"; do
  systemctl mask "$service"
done

for service in "${user_services[@]}"; do
  systemctl --global enable "$service"
done

echo "::endgroup::"
