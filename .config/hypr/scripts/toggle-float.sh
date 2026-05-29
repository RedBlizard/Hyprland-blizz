#!/bin/bash
# Float/unfloat active window with smart centering
hyprctl dispatch togglefloating
sleep 0.05
STATE=$(hyprctl activewindow -j | jq -r '.floating')
if [ "$STATE" = "true" ]; then
    hyprctl dispatch resizeactive exact 900 600
    hyprctl dispatch centerwindow
fi
