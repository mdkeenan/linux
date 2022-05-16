#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh every Sundary at 04:32 and run the commands.
# 32 4 * * 0 root sh /usr/local/src/mycron.sh >> /etc/crontab

CRONY="/etc/crontab"
MYCRONVAR="32 4 * * 0 root sh /usr/local/src/mycron.sh"

if grep -q mycron "$CRONY"; then
    # If "mycron" is present in crontab then select all lines in the crontab file that do NOT contain "mycron" and send them to a new file: tmpcrontab.
    # Then replaces crontab with tmpcrontab.
    grep -v "mycron" /etc/crontab > /usr/local/src/tmpcrontab && mv /usr/local/src/tmpcrontab > /etc/crontab
    # Insert's new chrontab.sh line to crontab file.
    echo $MYCRONVAR >> /etc/crontab
else
    echo $MYCRONVAR >> /etc/crontab
fi

curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycrontmp
