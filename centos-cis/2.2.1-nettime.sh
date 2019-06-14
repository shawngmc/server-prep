#!/bin/bash

# 2.2.1.2 Remove ntpd if installed
yum -y remove ntp ntpdate
 
# 2.2.1.3 Enable Chrony
sed -i "s/^OPTIONS=\"/OPTIONS=\"-u chrony /g" /etc/sysconfig/chronyd
systemctl stop chronyd
systemctl start chronyd
systemctl enable chronyd
