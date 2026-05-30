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
