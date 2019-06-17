#!/bin/bash

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

mkdir -pv /var/log/server-prep/

# Get updates 
yum check-update 2>&1 | tee /var/log/server-prep/updates.log

# Run customized miitgations
$scriptDir/antivirus.sh 2>&1 | tee /var/log/server-prep/antivirus.log
$scriptDir/filesystems.sh 2>&1 | tee /var/log/server-prep/filesystems.log
$scriptDir/nettime.sh 2>&1 | tee /var/log/server-prep/nettime.log
$scriptDir/ip.sh 2>&1 | tee /var/log/server-prep/ip.log
$scriptDir/crontab.sh 2>&1 | tee /var/log/server-prep/crontab.log
$scriptDir/ssh.sh 2>&1 | tee /var/log/server-prep/ssh.log
$scriptDir/password.sh 2>&1 | tee /var/log/server-prep/password.log
$scriptDir/process-hardening.sh 2 >&1 | tee /var/log/server-prep/process-hardening.sh

# Pull scanner and run
$scriptDir/pull-cis-scanner.sh | tee /var/log/server-prep/centos-audit.log
$scriptDir/cis-audit.sh 2>&1 | tee /var/log/server-prep/centos-audit.log
