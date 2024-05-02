#!/bin/bash

# Run eos-rankmirrors
kitty bash -c eos-rankmirrors

# Run the welcome script again after a short delay
sleep 2
bash $HOME/.config/hypr/scripts/yad_welcome.sh
