#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

DISABLE_REPOS=(
)

for repo in "${DISABLE_REPOS[@]}"; do
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/"$repo".repo
done

COPRS_TO_DISABLE=(
    trixieua/morewaita-icon-theme
    che/nerd-fonts
)

for copr in "${COPRS_TO_DISABLE[@]}"; do
    dnf5 -y copr disable "$copr"
done

echo "::endgroup::"
