#!/bin/bash
WIFI_IFACE="wlan0"

# Notify user
notify-send "Scanning for Wi-Fi networks..."

# Force rescan
nmcli device wifi rescan ifname "$WIFI_IFACE"

# Wait briefly to allow list to update
sleep 2

# Launch updated network list
bash "/home/denise/.config/hypr/hypr-network-manager/show_networks.sh"
