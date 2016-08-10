#!/bin/sh -eux

# Disable periodic activities of apt
cat <<EOF >/etc/apt/apt.conf.d/10disable-periodic
APT::Periodic::Enable "0";
EOF

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" >>/etc/network/interfaces;
