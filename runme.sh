#!/bin/sh

set -e

echo following packages will be installed: ${PACKAGES_TO_INSTALL}

apt update

cd /debs
apt-get download \
    $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts \
      --no-breaks --no-replaces --no-enhances \
      --no-pre-depends ${PACKAGES_TO_INSTALL} | grep "^\w")

genisoimage -l -U -joliet-long -rock -o "/iso-dir/to-install.iso" "/debs"
