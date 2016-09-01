#!/bin/sh -eux

rm -rf builds;

time packer build railsbox.json;
