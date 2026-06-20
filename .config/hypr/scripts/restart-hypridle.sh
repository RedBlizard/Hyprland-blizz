#!/bin/bash

# kill hypridle
killall hypridle

# Sleep
sleep 1

# Start hypridle
hypridle &

# notifycation
notify-send "hypridle has been restarted."
