#!/usr/bin/env bash

cd $1

# start with no machines
vagrant destroy -f
rm -rf .vagrant
rm -rf virtualbox.box
rm -rf virtualbox-build-output.log

time vagrant up --provider virtualbox 2>&1 | tee virtualbox-build-output.log
vagrant halt
vagrant package --base `ls ~/VirtualBox\ VMs | grep $1` --output virtualbox.box

ls -lh virtualbox.box
vagrant destroy -f
rm -rf .vagrant
