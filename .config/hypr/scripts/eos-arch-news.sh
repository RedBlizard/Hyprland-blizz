#!/bin/bash

# kill hypr-welcome
pkill -f yad

# Run eos-rankmirrors
eos-arch-news

# Run the welcome script again after a short delay
sleep 2
bash $HOME/.config/hypr/scripts/hypr-welcome
