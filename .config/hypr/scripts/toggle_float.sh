#!/bin/bash
# Float/unfloat the ACTIVE window with smart centering (works for any app)

# 1. Toggle the floating state for the currently focused window
hyprctl dispatch togglefloating
sleep 0.05

# 2. Check the new state (using the correct '.floating' JSON key)
STATE=$(hyprctl activewindow -j | jq -r '.floating')

if [ "$STATE" = "true" ]; then
    # 3. Center the window on the screen
    hyprctl dispatch centerwindow
    
    # Note: We removed the hardcoded 'resizeactive exact 900 454'. 
    # For general windows (like Brave or Kitty), it's much better 
    # to let them keep their current dimensions and just center them.
fi
