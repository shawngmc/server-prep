#!/bin/bash

# Install helm
curl -sfL https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | sh -
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller