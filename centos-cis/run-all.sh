#!/bin/bash

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

mkdir -pv /var/log/server-prep/

# Get updates 
yum check-update 2>&1 | tee /var/log/server-prep/updates.log

# Run customized CIS mitigations
$scriptDir/1.1.1-uncommon-filesystems.sh 2>&1 | tee /var/log/server-prep/cis.log
$scriptDir/2.2.1-nettime.sh 2>&1 | tee /var/log/server-prep/cis.log
$scriptDir/3.1.x-3.3.s-ip.sh 2>&1 | tee /var/log/server-prep/cis.log
$scriptDir/5.1.x-crontab.sh 2>&1 | tee /var/log/server-prep/cis.log
$scriptDir/5.2.x-ssh.sh 2>&1 | tee /var/log/server-prep/cis.log
$scriptDir/5.4.1-password.sh 2>&1 | tee /var/log/server-prep/cis.log

# Pull scanner and run
$scriptDir/pull-cis-scanner.sh | tee /var/log/server-prep/centos-audit.log
$scriptDir/cis-audit.sh 2>&1 | tee /var/log/server-prep/centos-audit.log
