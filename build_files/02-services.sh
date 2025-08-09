#!/bin/bash

echo "::group:: ===$(basename "$0")==="

set -euxo pipefail

services=(
)

disable_services=(
)

for service in "${services[@]}"; do
  systemctl enable "$service"
done

for service in "${disable_services[@]}"; do
  systemctl disable "$service"
done

user_services=(
)

for service in "${user_services[@]}"; do
  systemctl --global enable "$service"
done

echo "::endgroup::"
