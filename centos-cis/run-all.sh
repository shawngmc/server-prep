#!/bin/bash

mkdir -pv /var/log/server-prep/

# Get updates 
yum check-update 2>&1 | tee /var/log/server-prep/updates.log

# Run customized CIS mitigations
./server_prep/centos-cis/1.1.1-uncommon-filesystems.sh 2>&1 | tee /var/log/server-prep/cis.log
./server_prep/centos-cis/2.2.1-nettime.sh 2>&1 | tee /var/log/server-prep/cis.log
./server_prep/centos-cis/3.1.x-3.3.s-ip.sh 2>&1 | tee /var/log/server-prep/cis.log
./server_prep/centos-cis/5.1.x-crontab.sh 2>&1 | tee /var/log/server-prep/cis.log
./server_prep/centos-cis/5.2.x-ssh.sh 2>&1 | tee /var/log/server-prep/cis.log
./server_prep/centos-cis/5.4.1-password.sh 2>&1 | tee /var/log/server-prep/cis.log

# Pull scanner and run
./server_prep/centos-cis/pull-cis-scanner.sh | tee /var/log/server-prep/centos-audit.log
./server_prep/centos-cis/cis-audit.sh 2>&1 | tee /var/log/server-prep/centos-audit.log
