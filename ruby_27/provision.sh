#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export RUBY_VERSION=2.7.0

# Update Package List
apt-get update

# Install Kernel Headers
apt-get install -y linux-headers-$(uname -r) build-essential curl zip unzip

# Upgrade System Packages
apt-get dist-upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes

# Force Locale
echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
locale-gen en_US.UTF-8

# Install Some PPAs
apt-get install -y software-properties-common curl

# Update Package Lists
apt-get update

# Install Some Basic Packages
apt-get install -y build-essential dos2unix gcc git libmcrypt4 libpcre3-dev \
make python2.7-dev python-pip re2c unattended-upgrades whois vim \
libnotify-bin git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev \
libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties \
libffi-dev imagemagick libmagickcore-dev libmagickwand-dev

# Set Timezone
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

# Install Node and NPM
apt install -y nodejs

# Install Ruby
su -l -c 'git clone https://github.com/sstephenson/rbenv.git ~/.rbenv' vagrant
su -l -c 'git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build' vagrant
su -l -c 'git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars' vagrant

su -l -c 'cd ~/.rbenv && src/configure && make -C src' vagrant

su -l -c 'touch ~/.bash_profile' vagrant
su -l -c "echo 'export PATH=\"\$HOME/.rbenv/bin:\$PATH\"' >> ~/.bash_profile" vagrant
su -l -c "echo 'eval \"\$(rbenv init -)\"' >> ~/.bash_profile" vagrant
su -l -c "rbenv install $RUBY_VERSION" vagrant
su -l -c "rbenv global $RUBY_VERSION" vagrant

su -l -c "echo 'gem: --no-document' >> ~/.gemrc" vagrant
su -l -c 'gem install bundler -v 1.17.3' vagrant

su -l -c "echo 'cd /vagrant' >> ~/.bash_profile" vagrant
su -l -c "rbenv rehash >> ~/.bash_profile" vagrant

# Install MariaBD
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.coreix.net/mariadb/repo/10.4/ubuntu bionic main'
apt install -y mariadb-server mariadb-client libmysqlclient-dev

# Install Redis
apt-get install -y redis
systemctl enable redis-server
