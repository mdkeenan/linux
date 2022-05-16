#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh every hour.
# /etc/crontab 0 * * * * root sh /usr/local/src/ocrap.sh

# Download current version of ocrap.sh and save it to ocraptmp.sh
curl curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -o /usr/local/src/ocraptmp.sh

# Download latest version of ocrap-commands.sh.
source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap-commands.sh)

# Replace old version of ocrap.sh with new version.
mv /usr/local/src/ocraptmp.sh /usr/local/src/ocrap.sh

# Delete ocraptmp.sh
rm /usr/local/src/ocraptmp.sh
