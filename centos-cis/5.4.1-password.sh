#!/bin/bash

FILE=/etc/login.defs
login_config_modify () {
  KEY=$1
  VALUE=$2
  VALUE=${VALUE//\//\\\/}
  HAS_REGEX="^$KEY\s+.+\$"
  if grep -P "$HAS_REGEX" $FILE; then
    echo "replacing line"
    sed -i "s/^$KEY\s*.*\$/$KEY $VALUE/gm" $FILE
  else
    HAS_COMMENT_REGEX+="^#( )*$KEY\s+.+\$"
    if grep -P "$HAS_COMMENT_REGEX" $FILE; then
      echo "replacing comment"
      sed -i "s/^#\s*$KEY\s*.*\$/$KEY $VALUE/gm" $FILE
    else
      echo "Adding new"
      echo "" >> $FILE
      echo "$KEY $VALUE" >> $FILE
    fi
  fi
}
login_config_modify PASS_MAX_DAYS 90
login_config_modify PASS_MIN_DAYS 7
login_config_modify PASS_WARN_AGE 7
chage --mindays 7 $(whoami)
chage --maxdays 90 $(whoami)
chage --warndays 7 $(whoami)
chage --inactive 30 $(whoami)
useradd -D -f 30
