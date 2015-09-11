#Configuring a Sollatek UPS on Raspberry Pi

1. Connect the raspberry pi to the UPS Power outlet and connect the UPS's usb cable to the pi's usb port.
2. Power up the UPS and raspberry pi.
3. Login to the raspberry pi with your credentials. 
Default =(user:pi , pswd : raspberry)
4. **sudo su** to change to root user 
5. Use **lsusb** to view devices connected to the usb port 
*Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub*

*Bus 003 Device 002: ID 0665:5161 Cypress Semiconductor USB to Serial*

6. On the list that will be displayed, the vendor Id should by 0665 and product Id must also be 5161 for this configuration to work.
7. Use **sudo apt-get update**. If you encounter any error, use 
**sudo sh -c 'echo "nameserver 8.8.8.8" >> /etc/resolv.conf'** then run sudo apt-get update again then continue.
8. Now install NUT by running **sudo apt-get nut**
9. Next, declare sollatek as UPS in **/etc/nut/ups.conf** to be used with the **blazer_usb** driver.

*[sollatek]*
*driver = blazer_usb*
*port = /dev/ttyS0*
*desc = "Sollatek 850VA UPS" *
