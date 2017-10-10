#! /usr/bin/bash

sudo -v

curl http://brick.kernel.dk/snaps/fio-3.0.tar.gz --output fio-3.0.tar.gz
sudo yum -y install gcc
gunzip -f fio-3.0.tar.gz
tar -xf fio-3.0.tar
cd fio-3.0/
./configure
sudo make
sudo make install

device_unparsed=`sudo fdisk -l | grep 1098 | tail -1 | awk '{print $2}'`

device="${device_unparsed/:/}"

sudo mkfs.ext4 $device -F
sudo mkdir -p /mnt/disk1
sudo mount $device /mnt/disk1

sudo /usr/local/bin/fio --directory=/mnt/disk1 --name=tempfile.dat --direct=1 --rw=randwrite --bs=16k --size=2G --numjobs=2 --time_based --runtime=18000 --group_reporting
