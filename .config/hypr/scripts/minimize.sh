#!/bin/bash
ADDR=$(hyprctl activewindow -j | jq -r '.address')
if [ -n "$ADDR" ] && [ "$ADDR" != "null" ]; then
    hyprctl dispatch "hl.dsp.window.move({workspace = \"special:minimized\", window = \"address:${ADDR}\"})"
    hyprctl dispatch "hl.dsp.workspace.toggle_special(\"minimized\")"
fi
