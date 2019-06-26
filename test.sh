sudo systemctl start task
mv /blacklist blacklist
mv temp /blacklist
while read LINE; do $LINE ; done < /blacklist
sleep 30
temp=$(ps -eo comm | xargs -I {} grep '{}' /blacklist)
if ! [ -z "$temp" ]
	then
		echo "TEST FAILED"
	else
		echo "TEST OK"
fi
mv /blacklist temp
mv blacklist /blacklist
