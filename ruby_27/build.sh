#!/usr/bin/env bash

vagrant plugin install --local
vagrant box remove bento/ubuntu-18.04

# start with no machines
vagrant destroy -f
rm -rf .vagrant
rm -rf virtualbox.box
rm -rf virtualbox-build-output.log

vagrant plugin install --local

time vagrant up --provider virtualbox 2>&1 | tee virtualbox-build-output.log
vagrant halt
vagrant package --base `ls ~/VirtualBox\ VMs | grep railsbox` --output virtualbox.box

ls -lh virtualbox.box
vagrant destroy -f
rm -rf .vagrant
