#!/bin/bash

# Install SEManage
sudo yum -y install policycoreutils-python

# Fix Firewall
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 1 -i cni0 -s 10.42.0.0/16 -j ACCEPT
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 1 -s 10.42.0.0/15 -j ACCEPT
sudo firewall-cmd --reload

# Install K3S
curl -sfL https://get.k3s.io | sh -

# Fix perms and PATH for non-root user
sudo chmod 777 /etc/rancher/k3s/k3s.yaml
echo "export PATH=$PATH:/usr/local/bin/" >> ~/.bash_profile
source ~/.bash_profile

# Fix PATH for root user
#echo "export PATH=$PATH:/usr/local/bin/" >> ~/.bash_profile
#source ~/.bash_profile

# Wait 20 sec, then report if we're up
sleep 20
k3s kubectl get nodes

