#!/bin/bash
cd ~
touch networkPings.txt
PING="$(ping -c 10 www.google.ca | awk -F"[//]" '{print $5}' | tr -d '\n')"
SSID="$(sudo iwconfig | grep -o "\".*")"
SSIDINFILE="$(grep $SSID networkPings.txt)"
clear
if [ "$SSIDINFILE" == "" ]; then
	echo $SSID >> networkPings.txt
	echo $PING >> networkPings.txt
	echo "Added SSID to list (list is in home directory)"
else
	LINENUM="$(grep -n $SSID networkPings.txt | grep -Eo '^[^:]+')"
	LINENUM=$(($LINENUM+1))
	TESTEDPING=$(cat networkPings.txt | head -$LINENUM | tail -1)
	TESTEDPING=$(perl -e "print $TESTEDPING+3")
	if (( $(perl -e "print $PING>$TESTEDPING") )); then
		echo "Your connection may be comprimised"
	else
		echo "Your connection is probably safe"
	fi
	echo $TESTEDPING
	echo $PING
fi
