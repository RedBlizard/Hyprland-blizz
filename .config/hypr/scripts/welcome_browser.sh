#!/bin/bash

# launch brave-browser
xdg-open "$1"

# killing the welcome app
sleep 2
pkill -f yad

# Run the welcome script again after a short delay
sleep 3
bash "$HOME/.config/hypr/scripts/hypr-welcome"

