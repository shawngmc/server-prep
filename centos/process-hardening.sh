#!/bin/bash

# 1.5.1 Restrict core dumps
echo "* hard core 0" >> /etc/security/limits.d/20-nproc.conf
echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
sysctl -w fs.suid_dumpable=0

