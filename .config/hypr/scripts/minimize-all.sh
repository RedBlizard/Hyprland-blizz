#!/bin/bash
# Move all windows in the active workspace to special:minimized
WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')
hyprctl clients -j \
    | jq -r ".[] | select(.workspace.id == $WORKSPACE) | .address" \
    | while read -r addr; do
        hyprctl dispatch "hl.dsp.window.move({workspace = \"special:minimized\", window = \"address:${addr}\"})"
      done
# Hide the special workspace
hyprctl dispatch "hl.dsp.workspace.toggle_special(\"minimized\")"
