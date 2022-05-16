#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh every hour.
# /etc/crontab 0 * * * * root sh /usr/local/src/ocrap.sh

curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -o /usr/local/src/ocrap.sh
