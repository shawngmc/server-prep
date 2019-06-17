#!/bin/bash

# Install ClamAV
yum -y install epel-release
yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd

# Enable ClamAV in SELinux
setsebool -P antivirus_can_scan_system 1

# Create a ClamAV Config
cp /usr/share/clamav/template/clamd.conf /etc/clamd.d/clamd.conf
sed -i '/^Example/d' /etc/clamd.d/clamd.conf



sed -i 's//d' /etc/clamd.d/clamd.conf
sed -i '/^Example/d' /etc/clamd.d/clamd.conf
User clamscan
LocalSocket /var/run/clamd.<SERVICE>/clamd.sock
