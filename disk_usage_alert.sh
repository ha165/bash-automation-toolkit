#!/usr/bin/env bash

THRESHOLD=80

USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ $USAGE -gt $THRESHOLD ]
then
	echo "ALERT:Disk Usage is ${USAGE}%"
else
        echo "Disk usage is below ${THRESHOLD}% "
fi

