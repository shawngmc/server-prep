#!/bin/bash

FILE=/etc/ssh/sshd_config
sshd_config_modify () {
  KEY=$1
  VALUE=$2
  VALUE=${VALUE//\//\\\/}
  HAS_REGEX="^$KEY (.)+\$"
  if grep -P "$HAS_REGEX" $FILE; then
    echo "replacing line"
    sed -i "s/^\s*$KEY\s.*$/$KEY $VALUE/gm" /etc/ssh/sshd_config
  else
    HAS_COMMENT_REGEX+="^#( )*$KEY (.)+\$"
    if grep -P "$HAS_COMMENT_REGEX" $FILE; then
      echo "replacing comment"
      sed -i "s/^#\s*$KEY\s.*$/$KEY $VALUE/gm" /etc/ssh/sshd_config
    else
      echo "Adding new"
      echo "" >> $FILE
      echo "$KEY $VALUE" >> $FILE
    fi
  fi
}

sshd_config_modify Protocol 2
sshd_config_modify LogLevel INFO
sshd_config_modify X11Forwarding no
sshd_config_modify MaxAuthTries 3
sshd_config_modify IgnoreRhosts yes
sshd_config_modify HostbasedAuthentication no
sshd_config_modify PermitRootLogin no
sshd_config_modify PermitEmptyPasswords no
sshd_config_modify PermitUserEnvironment no
sshd_config_modify Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc
sshd_config_modify ClientAliveInterval 60
sshd_config_modify LoginGraceTime 45s
sshd_config_modify AllowGroups wheel
echo "Authorized Users Only" >> /etc/ssh/sshd-banner
sshd_config_modify Banner /etc/issue
sshd_config_modify MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
