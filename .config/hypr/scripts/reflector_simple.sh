#!/bin/bash

# Run reflector-simple
reflector-simple

# Run the welcome script again
Sleep 2
bash $HOME/.config/hypr/scripts/yad_welcome.sh
