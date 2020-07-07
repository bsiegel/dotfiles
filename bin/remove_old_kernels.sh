#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
export CURRENT=$(cat /proc/version | awk "{ print \$3 }")
echo "Autoremoving"
apt-get -o Dpkg::Options::="--force-confnew" autoremove --purge -y
echo "Removing old kernels"
dpkg --get-selections | awk "{ print \$1}" | grep linux-image-3 | sort | grep -v $CURRENT | head -n -2 | xargs sudo apt-get -o Dpkg::Options::="--force-confnew" purge -y
echo "Removing old headers"
dpkg --get-selections | awk "{ print \$1}" | grep linux-headers-3 | grep "[0-9]-[a-z]" | sort | grep -v $CURRENT | head -n -2 | xargs sudo apt-get -o Dpkg::Options::="--force-confnew" purge -y
