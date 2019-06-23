#!/bin/bash

# Add GH PubKeys
mkdir -pv ~/.ssh
curl https://github.com/shawngmc.keys -o /home/shawn/.ssh/authorized_keys
chmod g-w ~
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
