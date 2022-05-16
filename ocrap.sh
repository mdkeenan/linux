#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh every hour.
# /etc/crontab 0 * * * * root sh /usr/local/src/ocrap.sh

curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -o /usr/local/src/ocrap.varsource

cp /usr/local/src/ocrap.sh /usr/local/src/ocrap.varlocal

OCRAPSUMSOURCE=$(sha256sum /usr/local/src/ocrap.varsource)
OCRAPSUMLOCAL=$(sha256sum /usr/local/src/ocrap.varlocal)

OCRAPSUMSOURCE2=$(echo $OCRAPSUMSOURCE | awk -F" " '{print $1}')
OCRAPSUMLOCAL2=$(echo $OCRAPSUMLOCAL | awk -F" " '{print $1}')

if test "$OCRAPSUMSOURCE2" = "$OCRAPSUMLOCAL2"; then
    :
else
    cp /usr/local/src/ocrap.varsource /usr/local/src/ocrap.sh
fi

rm /usr/local/src/ocrap.varsource
rm /usr/local/src/ocrap.varlocal

# Enter commands below this line.
# Hello WOrld
