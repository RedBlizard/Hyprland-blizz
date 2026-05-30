#!/bin/bash
to_del=$(nmcli -t -f NAME,TYPE connection show | awk -F: '$2=="802-11-wireless" {print $1}' | yad --list --title='Delete Connection' --column='SSID' --width=400 --height=300)
[ -n "$to_del" ] && nmcli connection delete "$to_del" && notify-send "Deleted $to_del"
