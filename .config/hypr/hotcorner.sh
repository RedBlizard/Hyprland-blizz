#!/bin/bash
export WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-1}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
COOLDOWN=1
THRESHOLD=15
last_trigger=0

# Load monitor geometry at runtime so positions are always correct
load_monitors() {
    eval "$(hyprctl monitors -j 2>/dev/null | python3 -c "
import json, sys
for m in json.load(sys.stdin):
    n = m['name'].replace('-','_')
    print(f'{n}_X={m[\"x\"]}');   print(f'{n}_Y={m[\"y\"]}' )
    print(f'{n}_W={m[\"width\"]}'); print(f'{n}_H={m[\"height\"]}')
" 2>/dev/null)"
}
load_monitors

while true; do
    pos=$(hyprctl cursorpos 2>/dev/null)
    x=$(echo "$pos" | awk -F',' '{print int($1)}')
    y=$(echo "$pos" | awk -F',' '{print int($2)}')
    now=$(date +%s)
    diff=$((now - last_trigger))
    if [[ $diff -ge $COOLDOWN ]]; then
        if [[ $x -le $((DP_1_X + $THRESHOLD)) && $y -le $((DP_1_Y + $THRESHOLD)) ]]; then
            # CORNER:DP-1:tl:hl.plugin.hyprexpo.expo
            hyprctl dispatch "hl.plugin.hyprexpo.expo('toggle')"
            last_trigger=$now
            sleep 0.8
        elif [[ $x -ge $((HDMI_A_1_X + HDMI_A_1_W - $THRESHOLD)) && $y -le $((HDMI_A_1_Y + $THRESHOLD)) ]]; then
            # CORNER:HDMI-A-1:tr:hl.plugin.hyprexpo.expo
            hyprctl dispatch "hl.plugin.hyprexpo.expo('toggle')"
            last_trigger=$now
            sleep 0.8
        fi
    fi
    sleep 0.1
    # Reload monitor geometry every 60s in case of hotplug
    if [[ $(( $(date +%s) % 60 )) -eq 0 ]]; then load_monitors; fi
done
