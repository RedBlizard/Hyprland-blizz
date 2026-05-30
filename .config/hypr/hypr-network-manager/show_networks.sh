#!/bin/bash
WIFI_IFACE="wlan0"
IFS=$'\n'
wifi_entries=()
networks=$(nmcli -t -f IN-USE,SSID,SECURITY,SIGNAL device wifi list ifname "$WIFI_IFACE" | awk -F: '!seen[$2]++ {print}')

# Signal to bar graph mapper
bar_graph() {
    local sig=$1
    local bars=$((sig / 10))  # Max 10 levels
    local out=""
    for ((i = 0; i < bars; i++)); do
        out+="█"
    done
    for ((i = bars; i < 10; i++)); do
        out+="░"
    done
    echo "$out"
}

for net in $networks; do
    inuse=$(echo "$net" | cut -d: -f1)
    ssid=$(echo "$net" | cut -d: -f2)
    sec=$(echo "$net" | cut -d: -f3)
    sig=$(echo "$net" | cut -d: -f4)
    [ -z "$ssid" ] && continue
    [ -z "$sec" ] && sec="Open"
    status=""
    [ "$inuse" == "*" ] && status="(Connected)"
    bars=$(bar_graph "$sig")
    wifi_entries+=("$(printf "%-30s  |  %-8s  |  %3s%%  %s  %s" "$ssid" "$sec" "$sig" "$bars" "$status")")
    done
    
    printf "%s\n" "${wifi_entries[@]}" | yad --list     --title="Available Wi-Fi Networks"     --column="SSID | Security | Signal | Strength | Status"     --width=950 --height=420 --center     --button="   Back to main menu":0

