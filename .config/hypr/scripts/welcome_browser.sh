#!/bin/bash

# killing the welcome app
pkill -f yad

# Function to open a specific website in Brave browser
brave

# Run the welcome script again after a short delay
sleep 2
bash $HOME/.config/hypr/scripts/hypr-welcome
