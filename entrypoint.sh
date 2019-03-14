#!/bin/bash

PW="$(echo {A..Z} {a..z} {0..9} {0..9} '@ # % ^ ( ) _ + = - [ ] { } . ?' | tr ' ' "\n" | shuf | xargs | tr -d ' ' | cut -b 1-12)"

USER=${USER:-"pdfsplit"}
PASSWORD=${PASSWORD:-"$PW"}

        echo " "
        echo " "
        echo " "
        echo " "
	echo " "
	echo " "
	echo "      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	echo " "
	echo "      IF YOU DIDN'T SET THE PASSWORD FOR THE USER $USER"
	echo "      THE AUTOGENERATED PASSWORD IS: $PW"
	echo " "
	echo "      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
	echo " "
	echo " "

id -u $USER 1>/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
  useradd -m -u 1002 -U -s /usr/local/sbin/pdfsplit $USER
  echo "$USER:$PASSWORD" | chpasswd
  echo "$USER ALL = NOPASSWD:NOEXEC: /bin/mount, /bin/umount, /sbin/mount.cifs" > /etc/sudoers
fi

if [ -f /data/assets/pdftops-user.txt ]; then
  pdftopsuser="$(cat /data/assets/pdftops-user.txt|awk -F":" '{print $1}')"
  id -u $pdftopsuser 1>/dev/null 2>/dev/null
  if [ $? -ne 0 ]; then
    useradd -m -u 1003 -U -s /bin/bash $pdftopsuser
    cat /data/assets/pdftops-user.txt | chpasswd
  fi
fi

LOGFILE="/data/log/pdfsplit.log"

if [ ! -d /data/log ]; then
  mkdir -p /data/log
fi

if [ ! -f $LOGFILE ]; then
  touch $LOGFILE 
  chmod 666 $LOGFILE
fi

exec tail -f $LOGFILE &
exec "$@"
