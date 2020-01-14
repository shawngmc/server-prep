#!/bin/bash

# Install the necessary packages
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# Add docker repository
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install Containerd.io manually
sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm

# Install docker with the –nobest flag (do not limit the transaction to the best candidate)
sudo yum install --nobest docker-ce docker-ce-cli

# upgrade docker to the latest version:
sudo dnf update docker-ce docker-ce-cli

# Currently, Docker only works if the firewall is disabled
# Without disabling it, containers will not be able to resolve DNS
sudo systemctl stop firewalld
sudo systemctl disable firewalld

# Enable and start docker service
sudo systemctl enable docker
sudo systemctl start docker

