#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update Package List

apt-get update

# Update System Packages
apt-get -y dist-upgrade

# Force Locale

echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
locale-gen en_US.UTF-8

# Install Some PPAs

apt-get install -y software-properties-common curl
apt-add-repository ppa:chris-lea/redis-server -y

# Install node
curl --silent --location https://deb.nodesource.com/setup_7.x | bash -

# Update npm
npm install npm@latest -g

# Update Package Lists

apt-get update

# Install Some Basic Packages

apt-get install -y build-essential dos2unix gcc git libmcrypt4 libpcre3-dev \
make python2.7-dev python-pip re2c unattended-upgrades whois vim \
libnotify-bin git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev \
libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties \
libffi-dev

# Set Timezone

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Install Ruby

su -l -c 'git clone https://github.com/sstephenson/rbenv.git ~/.rbenv' vagrant
su -l -c 'git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build' vagrant
su -l -c 'git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars' vagrant

su -l -c 'cd ~/.rbenv && src/configure && make -C src' vagrant

su -l -c 'touch ~/.bash_profile' vagrant
su -l -c "echo 'export PATH=\"\$HOME/.rbenv/bin:\$PATH\"' >> ~/.bash_profile" vagrant
su -l -c "echo 'eval \"\$(rbenv init -)\"' >> ~/.bash_profile" vagrant
su -l -c 'rbenv install 2.4.2 && rbenv rehash' vagrant
su -l -c 'rbenv global 2.4.2 && rbenv rehash' vagrant

su -l -c 'gem install bundler rails --no-ri --no-rdoc' vagrant

# Install SQLite

apt-get install -y sqlite3 libsqlite3-dev

# Install MySQL

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
sudo apt-get install -y mysql-server-5.7 libmysqlclient-dev

# Configure MySQL Password Lifetime

echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

service mysql restart

# Add Timezone Support To MySQL

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql --user=root --password=vagrant mysql

# Install Postgres

apt-get install -y postgresql

# Install A Few Other Things

apt-get install -y redis-server nodejs

su -l -c "echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc" vagrant
