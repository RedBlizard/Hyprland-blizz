#!/bin/bash
# Restore all minimized windows to the active workspace
WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')
hyprctl clients -j \
    | jq -r '.[] | select(.workspace.name == "special:minimized") | .address' \
    | while read -r addr; do
        hyprctl dispatch "hl.dsp.window.move({workspace = \"${WORKSPACE}\", window = \"address:${addr}\"})"
      done
