#!/bin/bash

# Install SEManage
yum -y install policycoreutils-python

# Install Kubernetes Client
yum -y install kubernetes-client

# Install K3S
curl -sfL https://get.k3s.io | sh -

# Fix perms for non-root user
chmod 777 /etc/rancher/k3s/k3s.yaml

# Fix PATH for root user
echo "export PATH=$PATH:/usr/local/bin/" >> ~/.bash_profile
source ~/.bash_profile

# Wait 20 sec, then report if we're up
sleep 20
kubectl get nodes

