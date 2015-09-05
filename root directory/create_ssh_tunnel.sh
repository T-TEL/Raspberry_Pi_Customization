#!/bin/bash
read file_PortNumber < /boot/sshPortNumber.txt
createTunnel() {
  ###/usr/bin/ssh -N -R 2222:localhost:22 leomaxi@50.62.133.120
 /usr/bin/ssh -N -R $file_PortNumber:127.0.0.1:22 leomaxi@50.62.133.120 
if [[ $? -eq 0 ]]; then
    echo Tunnel to jumpbox created successfully
  else
    echo An error occurred creating a tunnel to jumpbox. RC was $?
  fi
}
/bin/pidof ssh
if [[ $? -ne 0 ]]; then
  echo Creating new tunnel connection
  createTunnel
fi
