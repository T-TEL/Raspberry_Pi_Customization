#!/bin/bash
#!/usr/bin/php
timestamp() {
  date +"%Y-%m-%d %T"
}
read file_facilityID < /boot/facilityID.txt
read prev_status < /root/holder/prevPowerStatus.txt
read prev_battery_level < /root/holder/prevBatteryLevel.txt
battery_level=$(/bin/upsc sollatek@localhost battery.charge)
ups_status=$(/bin/upsc sollatek@localhost ups.status)

###### Record Battery Level  if Changed
{
if [ "${battery_level}" != "${prev_battery_level}" ];
then
 echo "${battery_level}" > "/root/holder/prevBatteryLevel.txt"
 /usr/bin/php /root/save_logs/savelogIntodb.php "ups_battery_level" "${battery_level}" $file_facilityID
 echo "$(timestamp) BATTERY_STATUS ${battery_level}"
fi
} || {
 echo "Battery Check Failed"
}


##### Record UPS Power Status
{
if [ "${ups_status}" != "${prev_status}" ];
then
 echo "${ups_status}" > "/root/holder/prevPowerStatus.txt"
 /usr/bin/php /root/save_logs/savelogIntodb.php "ups_power_status" "{$ups_status}" $file_facilityID
 echo "$(timestamp) UPS_STATUS ${ups_status}"
fi
} || {
 echo "UPS Status Check Failed"
}

###### Internet Status
COUNT=4
SERVERIP=197.253.18.93
read prev_IntStatus < /root/holder/prev_IntStatus.txt
/bin/ping -c 3 $SERVERIP > /dev/null 2>&1
if [ $? -ne 0 ]
then
	if [ "Not Available" != "${prev_IntStatus}" ];
	then
 		echo "Not Available" > "/root/holder/prev_IntStatus.txt"
	/usr/bin/php /root/save_logs/savelogIntodb.php "internet_status" "Not Available" $file_facilityID
 		echo "$(timestamp) Internet Not Available"
	fi
else
	if [ "Available" != "${prev_IntStatus}" ];
        then
                echo "Available" > "/root/holder/prev_IntStatus.txt"
         /usr/bin/php /root/save_logs/savelogIntodb.php "internet_status" "Available"  $file_facilityID
                echo "$(timestamp) Internet Available"
        fi
fi

##### Network ISP
{
ISPsource="$(/usr/bin/php /root/getISP.php)"
read prev_ISP < /root/holder/prev_ISP.txt
if [ "${ISPsource}" != "${prev_ISP}" ];
then
 echo "${ISPsource}" > "/root/holder/prev_ISP.txt"
 /usr/bin/php /root/save_logs/savelogIntodb.php "internet_source" "${ISPsource}" $file_facilityID
 echo "$(timestamp) ISP ${ISPsource}"
fi
} || {
 echo "ISP Check Failed"
}
