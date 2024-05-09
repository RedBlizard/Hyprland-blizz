#!/bin/bash

# Define the icons
icondisabled="<span font='10'>󰾪</span>"
iconenabled="<span font='10'>󰅶</span>"
fifo="/tmp/waybar_hypridle_fifo"

if pgrep -x "hypridle" > /dev/null; then
   # Caffeine is enabled, so disable it
   killall hypridle
   # Update the Waybar module to display the disabled coffee cup icon immediately
   echo '{"text": "'"$icondisabled"'"}' > "$fifo"
   
else
   # Caffeine is disabled, so enable it
   hypridle -w /path/to/hypridle.conf &
   # Wait a bit to ensure hypridle starts before updating the icon
   sleep 1
   # Update the Waybar module to display the enabled coffee cup icon immediately
   echo '{"text": "'"$iconenabled"'"}' > "$fifo"
fi
