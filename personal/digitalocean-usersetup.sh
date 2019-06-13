#!/bin/bash

# Make a non-root user that can sudo
useradd shawn
mkdir -pv /home/shawn/.ssh
cp ~/.ssh/authorized_keys /home/shawn/.ssh/authorized_keys
chmod g-w /home/shawn
chmod 700 /home/shawn/.ssh
chmod 600 /home/shawn/.ssh/authorized_keys
chown -R shawn:shawn /home/shawn
usermod -aG wheel shawn
