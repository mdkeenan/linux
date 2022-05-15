#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh every hour.
# /etc/crontab 0 * * * * root sh /usr/local/src/ocrap.sh

curl -k -s https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -o /usr/local/src/ocrap.varsource

cp /usr/local/src/ocrap.sh /usr/local/src/ocrap.varlocal

OCRAPSUMSOURCE=$(sha256sum /usr/local/src/ocrap.varsource)
OCRAPSUMLOCAL=$(sha256sum /usr/local/src/ocrap.varlocal)

OCRAPSUMSOURCE2=$(echo $OCRAPSUMSOURCE | awk -F" " '{print $1}')
OCRAPSUMLOCAL2=$(echo $OCRAPSUMLOCAL | awk -F" " '{print $1}')

echo $OCRAPSUMSOURCE2
echo $OCRAPSUMLOCAL2

# now=$(date +"%T")
# echo "Updated: $now" >> /usr/local/src/ocrap

# rm /usr/local/src/ocrap.varsource
# rm /usr/local/src/ocrap.varlocal
