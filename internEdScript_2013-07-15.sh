#!/usr/bin/bash

###############################################################################
# File:		internEdScript_2013-07-16.sh
#
# Created:	07/15/2013
# Updated:	07/15/2013
#
# Desc:		Obtains a .txt file from a website, counts the number of lines
#	and uses conditions to output markers to stdout and stderr based upon the
#	results of a modulo operation. Then removes the file taken from the website
#	and sends the stderr information to a remote location using scp.
#
# Usage:	internEdScript_2013-07-16.sh <URL>
###############################################################################

wget -O internEdInput.txt $1

if [ -f /home/ben/Documents/internEd_logFile.txt ]
then
	rm -f /home/ben/Documents/internEd_logFile.txt
fi

num_lines=0
while read line
do
	(( num_lines = num_lines + 1 ))
	(( mod_num = num_lines % 101 ))
	if [ $mod_num -eq 0 ]
	then
		echo Hi $num_lines >> /home/ben/Documents/internEd_logFile.txt
	fi
done < internEdInput.txt
rm -f internEdInput.txt

echo Number of lines: $num_lines
echo Number of lines: $num_lines >> /home/ben/Documents/internEd_logFile.txt

scp /home/ben/Documents/internEd_logFile.txt storage@130.127.5.66:/home/storage/Documents/ben_logFile.txt
