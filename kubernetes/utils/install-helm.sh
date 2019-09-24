#!/bin/bash

# Install helm
curl -sfL https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | sh -
k3s kubectl -n kube-system create serviceaccount tiller
k3s kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller