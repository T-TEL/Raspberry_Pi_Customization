#!/bin/sh
#!/usr/bin/php
#Google Server 197.253.18.93
#Cloud Server 50.62.133.120
#Sample School ID = a9f0ca05c54c8f4ac8db4b4359000bfb_OLA
COUNT=4
SERVERIP=197.253.18.93
timestamp() {
  date +"%Y-%m-%d %T"
}
read file_facilityID < /boot/facilityID.txt

/bin/ping -c 3 $SERVERIP > /dev/null 2>&1
if [ $? -ne 0 ]
then
	#echo $file_facilityID
	/usr/bin/php /root/save_logs/savelogIntodb.php "internet_status" "Not Available" $file_facilityID
	echo "$(timestamp) Server Internet Down"
else
	#echo $file_facilityID
	/usr/bin/php /root/save_logs/savelogIntodb.php "internet_status" "Available" $file_facilityID
	echo "$(timestamp) Server Internert Working"
fi
