#!/bin/bash

# Install repo
sudo yum -y install centos-release-gluster

# Install Gluster server
sudo yum -y install glusterfs-server

# Set up service
systemctl enable glusterd
systemctl start glusterd
systemctl status glusterd

# Set up firewall rules for Gluster and up to five bricks
sudo firewall-cmd --permanent --add-port=24007/tcp
sudo firewall-cmd --permanent --add-port=24008/tcp
sudo firewall-cmd --permanent --add-port=49152/tcp
sudo firewall-cmd --permanent --add-port=49153/tcp
sudo firewall-cmd --permanent --add-port=49154/tcp
sudo firewall-cmd --permanent --add-port=49155/tcp
sudo firewall-cmd --permanent --add-port=49156/tcp
sudo firewall-cmd --reload