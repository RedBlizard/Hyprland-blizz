#!/bin/bash

# Get active connection info
active_conn=$(nmcli -t -f NAME,DEVICE,TYPE,STATE connection show --active | head -n1)

if [ -z "$active_conn" ]; then
    notify-send "Network Status" "No active network connection."
    exit 1
fi

name=$(echo "$active_conn" | cut -d: -f1)
device=$(echo "$active_conn" | cut -d: -f2)
type=$(echo "$active_conn" | cut -d: -f3)
state=$(echo "$active_conn" | cut -d: -f4)

ip_addr=$(ip -4 addr show "$device" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

notify-send "Network Status" "Connection: $name
Device: $device
Type: $type
State: $state
IP: $ip_addr"
