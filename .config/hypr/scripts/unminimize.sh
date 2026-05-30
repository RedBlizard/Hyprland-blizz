#!/bin/bash
# Restore the most recently minimized window
LAST=$(hyprctl clients -j \
    | jq -r '[.[] | select(.workspace.name == "special:minimized")] | last | .address')
if [ -n "$LAST" ] && [ "$LAST" != "null" ]; then
    WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')
    hyprctl dispatch "hl.dsp.window.move({workspace = \"${WORKSPACE}\", window = \"address:${LAST}\"})"
fi
