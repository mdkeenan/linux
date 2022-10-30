#!/bin/bash

# Bash Examples

# Tests two files to see if they match. If they do then do something if they don't then make the file.

OCRAPSUMSOURCE=$(sha256sum /usr/local/src/ocrap.varsource)
OCRAPSUMLOCAL=$(sha256sum /usr/local/src/ocrap.varlocal)

OCRAPSUMSOURCE2=$(echo $OCRAPSUMSOURCE | awk -F" " '{print $1}')
OCRAPSUMLOCAL2=$(echo $OCRAPSUMLOCAL | awk -F" " '{print $1}')

if test "$OCRAPSUMSOURCE2" = "$OCRAPSUMLOCAL2"; then
    :
else
    cp /usr/local/src/ocrap.varsource /usr/local/src/ocrap.sh
fi


# Use grep to delete a line from a file.

grep -v 'line to delete' testfile.txt > tmpfile && mv tmpfile testfile.txt
