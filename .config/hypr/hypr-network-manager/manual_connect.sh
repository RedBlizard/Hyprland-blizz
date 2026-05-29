#!/bin/bash
SSID=$(yad --entry --title='Manual SSID' --text='Enter SSID:')
[ -z "$SSID" ] && exit
PASS=$(yad --entry --title='Password' --text='Enter password:' --hide-text)
nmcli dev wifi connect "$SSID" password "$PASS" ifname "wlan0" && notify-send "Connected to $SSID"
