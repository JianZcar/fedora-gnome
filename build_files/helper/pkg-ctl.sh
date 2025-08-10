#!/bin/bash

set -ouex pipefail

ACTION="$1"
shift || true

# Store the arguments into an array
PKGS=("$@")

if [[ "$ACTION" == "install" ]]; then
    for pkg in "${PKGS[@]}"; do
        dnf5 install -y "$pkg"
    done
elif [[ "$ACTION" == "uninstall" ]]; then
    for pkg in "${PKGS[@]}"; do
        dnf5 remove -y "$pkg"
    done
else
    echo "Usage: $0 install|uninstall packages..."
    exit 1
fi
