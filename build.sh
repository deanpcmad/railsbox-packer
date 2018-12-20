#!/usr/bin/env bash

vagrant box remove bento/ubuntu-18.04

# install required vagrant plugin to handle reloads during provisioning
vagrant plugin install vagrant-reload

# install plugin to update virtualbox guest additions to latest version
vagrant plugin install vagrant-vbguest

# start with no machines
vagrant destroy -f
rm -rf .vagrant
rm -rf virtualbox.box

time vagrant up --provider virtualbox 2>&1 | tee virtualbox-build-output.log
vagrant halt
vagrant package --base `ls ~/VirtualBox\ VMs | grep railsbox` --output virtualbox.box

ls -lh virtualbox.box
vagrant destroy -f
rm -rf .vagrant
