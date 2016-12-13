#!/bin/sh

SSID="WISE-work"
WPA_KEY="advantech"

rfkill unblock all
killall wpa_supplicant
rm /etc/resolv.conf
ifconfig wlan0 up

wpa_passphrase ${SSID} ${WPA_KEY} > /tmp/wpa.conf
wpa_supplicant -BDwext -iwlan0 -c/tmp/wpa.conf
udhcpc -b -i wlan0
ping 8.8.8.8 &

/tools/stress.sh

