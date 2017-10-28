#!/usr/bin/env bash

# Enable Swap Memory

/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
chmod 600 /var/swap.1
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

# Minimize The Disk Image

echo "Minimizing disk image..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
