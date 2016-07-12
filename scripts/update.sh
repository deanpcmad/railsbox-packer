#!/bin/sh -eux

# Disable release-upgrades
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades;

# Update the package list
apt-get -y update;

# Upgrade all installed packages incl. kernel and kernel headers
apt-get -y dist-upgrade --force-yes;
reboot;
sleep 60;

# Disable periodic activities of apt
cat <<EOF >/etc/apt/apt.conf.d/10disable-periodic
APT::Periodic::Enable "0";
EOF
