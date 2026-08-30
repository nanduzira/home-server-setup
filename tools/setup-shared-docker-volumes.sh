#!/bin/bash

set -euo pipefail

DOCKER_VOLUME_NAME=$1
LINUX_DEVICE=$2

if [ -z "$DOCKER_VOLUME_NAME" ] || [ -z "$LINUX_DEVICE" ]; then
  echo "Usage: $0 <docker-volume-name> <linux-device>"
  exit 1
fi

docker volume create --driver local \
  --opt type=ext4 \
  --opt o=rw,noatime \
  --opt device="${LINUX_DEVICE}" \
  "${DOCKER_VOLUME_NAME}"

################# SAMPLE USAGE IN DOCKER-COMPOSE.YAML #################
# services:
#   web_app:
#     image: nginx
#     volumes:
#       - type: volume
#         source: shared_ext4_disk
#         target: /var/www/html
#         volume:
#           subpath: "frontend"  # Isolates to a subfolder

# volumes:
#   shared_ext4_disk:
#     external: true             # Tells compose NOT to create/mount it
#######################################################################
