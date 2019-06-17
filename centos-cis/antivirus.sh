#!/bin/bash

# Install ClamAV
yum -y install epel-release
yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd

# Enable ClamAV in SELinux
setsebool -P antivirus_can_scan_system 1

# Create a ClamAV Config
cp /usr/share/clamav/template/clamd.conf /etc/clamd.d/clamd.conf
sed -i '/^Example/d' /etc/clamd.d/clamd.conf
sed -i "s/^User <USER>$/User clamscan/gm" /etc/clamd.d/clamd.conf
sed -i "s/^#LocalSocket/LocalSocket/gm" /etc/clamd.d/clamd.conf

# Enable Freshclam DB Updater
cp /etc/freshclam.conf /etc/freshclam.conf.bak
sed -i '/^Example/d' /etc/freshclam.conf

# Add a systemd service for freshclam
cat > /usr/lib/systemd/system/clam-freshclam.service << "EOF"
# Run the freshclam as daemon
[Unit]
Description = freshclam scanner
After = network.target

[Service]
Type = forking
ExecStart = /usr/bin/freshclam -d -c 4
Restart = on-failure
PrivateTmp = true

[Install]
WantedBy=multi-user.target
EOF

# Enable and start freshclam
systemctl enable clam-freshclam.service
systemctl start clam-freshclam.service

# Clean up the clamav service definition
mv /usr/lib/systemd/system/clamd@.service /usr/lib/systemd/system/clamd.service
sed -i "s/clamd@.service/clamd.service/gm" /usr/lib/systemd/system/clamd@scan.service
cat > /usr/lib/systemd/system/clamd.service << "EOF"
[Unit]
Description = clamd scanner daemon
After = syslog.target nss-lookup.target network.target

[Service]
Type = simple
ExecStart = /usr/sbin/clamd -c /etc/clamd.d/clamd.conf --foreground=yes
Restart = on-failure
PrivateTmp = true

[Install]
WantedBy=multi-user.target
EOF

systemctl enable clamd.service
systemctl enable clamd@scan.service
systemctl start clamd.service
systemctl start clamd@scan.service
