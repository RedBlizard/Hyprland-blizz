#!/bin/sh
wlogout --protocol layer-shell -b 5 -T 400 -B 400

# Terminate already running bar instances

killall -q waybar

# Wait until the waybar processes have been shut down

while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main

waybar
