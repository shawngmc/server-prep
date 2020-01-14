#!/bin/bash

# Start-Image
sudo docker run -d --restart=unless-stopped \
  -p 8080:80 -p 8443:443 \
  -v /opt/rancher:/var/lib/rancher \
  rancher/rancher:latest
