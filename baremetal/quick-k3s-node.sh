#!/bin/bash

# Pull ssh key
../usersetup.sh

# Install K3S
../kubernetes/k3s/install.sh

# Install Helm
../kubernetes/utils/install-helm.sh