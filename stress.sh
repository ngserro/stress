#! /usr/bin/bash

sudo -v

device_unparsed=`sudo fdisk -l | grep 1098 | tail -1 | awk '{print $2}'`;
device="${device_unparsed/:/}"

sudo mount $device /mnt/disk1

sudo fallocate -l 900G /mnt/disk1/fallocate_file