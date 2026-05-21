#!/bin/bash

# Define paths and logo
SCRIPT_DIR="$HOME/.config/hypr/hypr-network-manager"
mkdir -p "$SCRIPT_DIR"
logo_path="$HOME/.config/hypr/imgs/hypr-welcome.png"
kill_script="$HOME/.config/hypr/scripts/kill-hypr-welcome"

# Detect interfaces
WIFI_IFACE=$(nmcli device | awk '$2 == "wifi" {print $1}' | head -n 1)
ETH_INTERFACES=($(nmcli device | awk '$2 == "ethernet" {print $1}'))

########## Create Scripts ##########

# Wi-Fi Enable
cat > "$SCRIPT_DIR/wifi_enable.sh" << EOF
#!/bin/bash
nmcli radio wifi on
notify-send 'Wi-Fi enabled'
EOF
chmod +x "$SCRIPT_DIR/wifi_enable.sh"

# Wi-Fi Disable
cat > "$SCRIPT_DIR/wifi_disable.sh" << EOF
#!/bin/bash
nmcli radio wifi off
notify-send 'Wi-Fi disabled'
EOF
chmod +x "$SCRIPT_DIR/wifi_disable.sh"

# Ethernet Enable
cat > "$SCRIPT_DIR/eth_enable.sh" << EOF
#!/bin/bash
$(for i in "${ETH_INTERFACES[@]}"; do echo "nmcli device connect $i"; done)
notify-send 'Wired enabled'
EOF
chmod +x "$SCRIPT_DIR/eth_enable.sh"

# Ethernet Disable
cat > "$SCRIPT_DIR/eth_disable.sh" << EOF
#!/bin/bash
$(for i in "${ETH_INTERFACES[@]}"; do echo "nmcli device disconnect $i"; done)
notify-send 'Wired disabled'
EOF
chmod +x "$SCRIPT_DIR/eth_disable.sh"

# Manual Wi-Fi Connect
cat > "$SCRIPT_DIR/manual_connect.sh" << EOF
#!/bin/bash
SSID=\$(yad --entry --title='Manual SSID' --text='Enter SSID:')
[ -z "\$SSID" ] && exit
PASS=\$(yad --entry --title='Password' --text='Enter password:' --hide-text)
nmcli dev wifi connect "\$SSID" password "\$PASS" ifname "$WIFI_IFACE" && notify-send "Connected to \$SSID"
EOF
chmod +x "$SCRIPT_DIR/manual_connect.sh"

# Delete Saved Connection
cat > "$SCRIPT_DIR/delete_conn.sh" << EOF
#!/bin/bash
to_del=\$(nmcli -t -f NAME,TYPE connection show | awk -F: '\$2=="802-11-wireless" {print \$1}' | yad --list --title='Delete Connection' --column='SSID' --width=400 --height=300)
[ -n "\$to_del" ] && nmcli connection delete "\$to_del" && notify-send "Deleted \$to_del"
EOF
chmod +x "$SCRIPT_DIR/delete_conn.sh"

# Bluetooth Toggle
cat > "$SCRIPT_DIR/bt_toggle.sh" << EOF
#!/bin/bash
if rfkill list bluetooth | grep -q 'Soft blocked: yes'; then
    rfkill unblock bluetooth && notify-send 'Bluetooth enabled'
else
    rfkill block bluetooth && notify-send 'Bluetooth disabled'
fi
EOF
chmod +x "$SCRIPT_DIR/bt_toggle.sh"

# WWAN Disable
cat > "$SCRIPT_DIR/wwan_disable.sh" << EOF
#!/bin/bash
nmcli radio wwan off
notify-send 'WWAN disabled'
EOF
chmod +x "$SCRIPT_DIR/wwan_disable.sh"

# WWAN Enable
cat > "$SCRIPT_DIR/wwan_enable.sh" << EOF
#!/bin/bash
nmcli radio wwan on
notify-send 'WWAN enabled'
EOF
chmod +x "$SCRIPT_DIR/wwan_enable.sh"

# Save/Reload Connections
cat > "$SCRIPT_DIR/save_conn.sh" << EOF
#!/bin/bash
nmcli connection reload
notify-send 'Connections reloaded'
EOF
chmod +x "$SCRIPT_DIR/save_conn.sh"

# Open Network Editor
cat > "$SCRIPT_DIR/conn_editor.sh" << EOF
#!/bin/bash
nm-connection-editor
EOF
chmod +x "$SCRIPT_DIR/conn_editor.sh"

# Close Action (Placeholder)
cat > "$SCRIPT_DIR/close.sh" << EOF
#!/bin/bash
echo Exiting
EOF
chmod +x "$SCRIPT_DIR/close.sh"

# Show Networks Script with Textual Signal Bars
cat > "$SCRIPT_DIR/show_networks.sh" << EOF
#!/bin/bash
WIFI_IFACE="$WIFI_IFACE"
IFS=\$'\\n'
wifi_entries=()
networks=\$(nmcli -t -f IN-USE,SSID,SECURITY,SIGNAL device wifi list ifname "\$WIFI_IFACE" | awk -F: '!seen[\$2]++ {print}')

# Signal to bar graph mapper
bar_graph() {
    local sig=\$1
    local bars=\$((sig / 10))  # Max 10 levels
    local out=""
    for ((i = 0; i < bars; i++)); do
        out+="█"
    done
    for ((i = bars; i < 10; i++)); do
        out+="░"
    done
    echo "\$out"
}

for net in \$networks; do
    inuse=\$(echo "\$net" | cut -d: -f1)
    ssid=\$(echo "\$net" | cut -d: -f2)
    sec=\$(echo "\$net" | cut -d: -f3)
    sig=\$(echo "\$net" | cut -d: -f4)
    [ -z "\$ssid" ] && continue
    [ -z "\$sec" ] && sec="Open"
    status=""
    [ "\$inuse" == "*" ] && status="(Connected)"
    bars=\$(bar_graph "\$sig")
    wifi_entries+=("\$(printf "%-30s  |  %-8s  |  %3s%%  %s  %s" "\$ssid" "\$sec" "\$sig" "\$bars" "\$status")")
    done
    
    printf "%s\\n" "\${wifi_entries[@]}" | yad --list \
    --title="Available Wi-Fi Networks" \
    --column="SSID | Security | Signal | Strength | Status" \
    --width=950 --height=420 --center \
    --button="   Back to main menu":0

EOF
chmod +x "$SCRIPT_DIR/show_networks.sh"

# Rescan Networks Script
cat > "$SCRIPT_DIR/rescan_networks.sh" << EOF
#!/bin/bash
WIFI_IFACE="$WIFI_IFACE"

# Notify user
notify-send "Scanning for Wi-Fi networks..."

# Force rescan
nmcli device wifi rescan ifname "\$WIFI_IFACE"

# Wait briefly to allow list to update
sleep 2

# Launch updated network list
bash "$SCRIPT_DIR/show_networks.sh"
EOF
chmod +x "$SCRIPT_DIR/rescan_networks.sh"

cat > "$SCRIPT_DIR/check_connection.sh" << 'EOF'
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
EOF
chmod +x "$SCRIPT_DIR/check_connection.sh"

cat > "$SCRIPT_DIR/network_diagnose.sh" << 'EOF'
#!/bin/bash

notify-send "Network Diagnose" "Starting diagnostics..."

# Check default route
default_route=$(ip route show default | head -n1)
if [ -z "$default_route" ]; then
    notify-send "Network Diagnose" "❌ No default route found."
    exit 1
fi

gateway=$(echo "$default_route" | awk '{print $3}')
if [ -z "$gateway" ]; then
    notify-send "Network Diagnose" "❌ No default gateway found."
    exit 1
fi

# Ping gateway (warning only)
ping -c 2 "$gateway" > /tmp/ping_gateway.log 2>&1
gw_status=$?

# Ping Google DNS IP
ping -c 2 8.8.8.8 > /tmp/ping_google.log 2>&1
google_status=$?

# DNS resolution test
dns_test=$(getent hosts google.com)
dns_status=$?

# HTTP HEAD request test (requires curl or wget)
if command -v curl >/dev/null 2>&1; then
    http_status=$(curl -Is --max-time 5 https://www.google.com | head -n1)
elif command -v wget >/dev/null 2>&1; then
    http_status=$(wget --server-response --timeout=5 --spider https://www.google.com 2>&1 | head -n1)
else
    http_status=""
fi

# Compose result message
msg="Network Diagnostics Result:

Default Gateway: $gateway
"

if [ $gw_status -eq 0 ]; then
    msg+="✅ Gateway is reachable (ping succeeded).
"
else
    msg+="⚠️ Gateway ping failed (some gateways block ping; this may not indicate an issue).
"
fi

if [ $google_status -eq 0 ]; then
    msg+="✅ Google DNS (8.8.8.8) is reachable.
"
else
    msg+="❌ Google DNS (8.8.8.8) unreachable.
"
fi

if [ $dns_status -eq 0 ]; then
    msg+="✅ DNS resolution working (google.com resolves).
"
else
    msg+="❌ DNS resolution failed for google.com.
"
fi

if [[ "$http_status" == *"200"* ]]; then
    msg+="✅ HTTP connectivity to https://www.google.com is OK.
"
elif [[ -z "$http_status" ]]; then
    msg+="⚠️ HTTP test skipped (curl or wget not found).
"
else
    msg+="❌ HTTP connectivity to https://www.google.com failed.
"
fi

notify-send "Network Diagnose" "$msg"
EOF
chmod +x "$SCRIPT_DIR/network_diagnose.sh"

########## Bluetooth Icon State ##########
BT_BLOCKED=$(rfkill list bluetooth | grep -i "Soft blocked: yes")
BT_ICON="󰂯  Bluetooth toggle"
[ -n "$BT_BLOCKED" ] && BT_ICON="󰂯  Enable Bluetooth"

########## Show YAD Main Form ##########
create_yad_dialog() {
yad --title="YAD Network Manager" \
    --image="$logo_path" --image-placement=left --image-on-top \
    --borders=3 \
    --geometry=900x410+800+200 \
    --form \
    --columns=3 \
    --geometry=900x410+800+200 \
      --tabs-position=top \
         --tab="Show Networks" \
            --form \
            --columns=3 \
            --field="󰤨   Show Networks:FBTN" "bash $SCRIPT_DIR/show_networks.sh" \
            --field="󰖩  Enable Wi-Fi:FBTN" "bash $SCRIPT_DIR/wifi_enable.sh" \
            --field="󰖪  Disable Wi-Fi:FBTN" "bash $SCRIPT_DIR/wifi_disable.sh" \
            --field="󰜉  Rescan Wi-Fi:FBTN" "bash $SCRIPT_DIR/rescan_networks.sh" \
            --field="󰁪  Manual Connect:FBTN" "bash $SCRIPT_DIR/manual_connect.sh" \
            --field="   Enable Wired:FBTN" "bash $SCRIPT_DIR/eth_enable.sh" \
            --field="󰌙   Disable Wired:FBTN" "bash $SCRIPT_DIR/eth_disable.sh" \
            --field="$BT_ICON:FBTN" "bash $SCRIPT_DIR/bt_toggle.sh" \
            --field="  Disable WWAN:FBTN" "bash $SCRIPT_DIR/wwan_disable.sh" \
            --field="  Enable WWAN:FBTN" "bash $SCRIPT_DIR/wwan_enable.sh" \
            --field="󱘖  Save Connections:FBTN" "bash $SCRIPT_DIR/save_conn.sh" \
            --field="  Delete Connection:FBTN" "bash $SCRIPT_DIR/delete_conn.sh" \
            --field="󱊪  Check Connection:FBTN" "bash $SCRIPT_DIR/check_connection.sh" \
            --field="󱌢  Diagnose Network:FBTN" "bash $SCRIPT_DIR/network_diagnose.sh" \
            --field="󰌘  Connection Editor:FBTN" "bash $SCRIPT_DIR/conn_editor.sh" \
            --button="<span font_desc='CustomFont 10'></span>  You can just close me, if you want to....." "bash $kill_script":0 \
          --no-cancel \
        --no-focus \
      --separator="," \
    --timeout=0 &

}

# Create Yad dialog
create_yad_dialog

# Trap to clean up zombie processes
trap "sleep 0.2 ; $HOME/.config/hypr/scripts/kill_zombies.sh --silent" EXIT

exit 0
