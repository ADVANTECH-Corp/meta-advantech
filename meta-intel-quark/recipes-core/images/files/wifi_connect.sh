#!/bin/sh
if [ $# != 2 ]; then
cat << SYNTAX

Syntax:
	$0 {SSID} {passphrase}

Notice:
	If SSID contains space char, using double quotes, ex. "SS ID".
	Do not use space char in passphrase.

SYNTAX
exit 1
fi

NAME=$1
PASS=$2
SSID=`echo -n "$NAME" | hexdump -v -e '/1 "%02x"'`
space=0
WIFICFG="/var/lib/connman/wifi.config"
SERVICE=

if [ "$NAME" != ${NAME/ /} ]; then
    space=1
    echo "** space char detected **"
fi

echo -n "Scanning WiFi..."
if connmanctl scan wifi &>/dev/null; then
    echo "done"
else
    echo "failed"
    exit 1
fi

echo -n "Checking available service..."
if SERVICE=$(connmanctl services | grep "_${SSID}_.*psk" 2>/dev/null); then
    echo "found"
else
    echo "\"$NAME\" not found"
    exit 1
fi
SERVICE=wifi_${SERVICE#* wifi_}

cat << EOF > $WIFICFG
[service_${SERVICE}]
Type = wifi
Name = $NAME
Passphrase = $PASS
EOF

if [ $space == 1 ]; then
    sed -i "s/Name = .*/SSID = $SSID/" $WIFICFG
fi

if ! connmanctl connect $SERVICE; then
    echo "connection failed"
fi
