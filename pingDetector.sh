#!/bin/bash
# get state of ethernet interface (3 for wireless): ip link show | grep "2: " | grep -oP '(?<=state ).*(?= mode)'
cd ~
touch networkPings.txt
PING="$(ping -c 10 www.google.ca | awk -F"[//]" '{print $5}' | tr -d '\n')"
SSID="$(sudo iwconfig | grep -o "\".*")"
clear
if [ "$(grep $SSID networkPings.txt)" == "" ]; then
	echo $SSID >> networkPings.txt
	echo $PING >> networkPings.txt
	echo "Added SSID to list"
else
	LINENUM="$(grep -n $SSID networkPings.txt | grep -Eo '^[^:]+')"
	LINENUM=$(($LINENUM+1))
	TESTEDPING=$(cat networkPings.txt | head -$LINENUM | tail -1)
	if (( $(perl -e "print $PING>($TESTEDPING+2)") )); then
		echo "Your connection may be comprimised"
	else
		echo "Your connection is probably safe"
	fi
	echo "Ping from file: $TESTEDPING"
	echo "Ping tested: $PING"
fi
