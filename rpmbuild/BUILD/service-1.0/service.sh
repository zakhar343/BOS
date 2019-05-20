#!/bin/bash
trap ' echo -n "Signal SIGUSR1 received. " ' USR1
trap ' echo "Service Stopped"; exit 0' TERM
echo "Service Started" 
while :
do
	temp=$(ps -eo comm | xargs -I {} grep '{}' /blacklist)
	# echo -n "Checked in `date`. "
	if ! [ -z "$temp" ]
	then
		echo -n "Killed processes:"
		ps -eo comm | xargs -I {} grep '{}' /blacklist | xargs | tr ' ' ', '
	else
		echo "No processes were killed!"
	fi
	ps -eo comm | xargs -I {} grep '{}' /blacklist | xargs -n 1 pkill 2>/dev/null
	sleep 30 &
	wait $!
done
