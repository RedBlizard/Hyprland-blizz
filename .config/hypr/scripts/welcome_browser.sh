#!/bin/bash

# sleep 1
sleep 

# killing the welcome ap
pkill -f yad

# launch brave-browser
xdg-open "$1"

# Run the welcome script again after a short delay
sleep 2
bash "$HOME/.config/hypr/scripts/hypr-welcome"

