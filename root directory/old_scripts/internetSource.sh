#!/bin/bash
#!/usr/bin/php

ISPsource="$(/usr/bin/php /root/getISP.php)"

read file_facilityID < /boot/facilityID.txt

timestamp() {
  date +"%Y-%m-%d %T"
}

##echo $file_facilityID
echo "$(timestamp) ${ISPsource}"

echo "$(timestamp) ${ISPsource}" >> /root/internet.log

/usr/bin/php /root/save_logs/savelogIntodb.php "internet_source" "${ISPsource}" $file_facilityID



