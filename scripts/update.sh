#!/bin/sh -eux

# Disable release-upgrades
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades;

# Update the package list
apt-get -y update;

# Upgrade all installed packages incl. kernel and kernel headers
apt-get -y dist-upgrade --force-yes;
reboot;
sleep 60;
