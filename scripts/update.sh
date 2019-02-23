#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update Package List

apt-get update

# Install Kernel Headers

apt-get install -y linux-headers-$(uname -r) build-essential curl zip unzip

# Upgrade System Packages

apt-get dist-upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes
