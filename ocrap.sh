#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh every hour.
# /etc/crontab 0 * * * * root sh /usr/local/src/ocrap.sh

wget --no-check-certificate -q https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -O /usr/local/src/ocrap.varsource

cp /usr/local/src/ocrap.sh /usr/local/src/ocrap.varlocal

OCRAPSUMSOURCE=$(sha256sum /usr/local/src/ocrap.varsource)
OCRAPSUMLOCAL=$(sha256sum /usr/local/src/ocrap.varlocal)

echo $OCRAPSUMSOURCE
echo $OCRAPSUMLOCAL

now=$(date +"%T")
echo "Updated: $now" >> /usr/local/src/ocrap

rm /usr/local/src/ocrap.varsource
rm /usr/local/src/ocrap.varlocal
