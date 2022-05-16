#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh every Sundary at 04:32 and run the commands.
# 32 4 * * 0 root sh /usr/local/src/mycron.sh >> /etc/crontab

curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycrontmp.sh

sh /usr/local/src/mycrontmp.sh

grep -v "mycron" /etc/crontab > /usr/local/src/tmpcrontab && mv /usr/local/src/tmpcrontab /etc/crontab

MYCRONVAR="* * * * * root sh /usr/local/src/mycron.sh"

echo "$MYCRONVAR" >> /etc/crontab

mv /usr/local/src/mycrontmp.sh /usr/local/src/mycron.sh

rm /usr/local/src/tmpcrontab
rm /usr/local/src/mycrontmp.sh
