#!/bin/sh

set -e
OUT_DIR=/iso-dir

if [ "$#" -eq 0 ]; then
     echo "No packages list provided, default list will be used."
fi
CMDLINE="$*"
PACKAGES_TO_INSTALL=${CMDLINE:-"lldpd ifenslave net-tools"}

echo "Following packages will be added to iso: ${PACKAGES_TO_INSTALL}\n\n"

if ! mountpoint -q "${OUT_DIR}" ; then
  echo "looks like ${OUT_DIR} is not mounted, don't want to store .iso inside container. Exiting..."
  exit 1
fi

apt update

cd /debs
apt-get download \
    $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts \
      --no-breaks --no-replaces --no-enhances \
      --no-pre-depends "${PACKAGES_TO_INSTALL}" | grep "^\w")

genisoimage -l -U -joliet-long -rock -o "${OUT_DIR}/to-install.iso" "/debs"
