#!/bin/bash
# Toggle between Laptop (eDP-1) and TV (HDMI-A-1) modes
# - Laptop mode: removes "disable" rule entirely, enables eDP-1
# - TV mode: adds "disable" rule for eDP-1, moves workspaces to HDMI-A-1

MONITOR_CONF="$HOME/.config/hypr/conf/monitor.conf"
WORKSPACE_CONF="$HOME/.config/hypr/conf/workspaces.conf"

# 1. Determine current state by checking workspace 1 assignment
if grep -q "^workspace=1,monitor:HDMI-A-1" "$WORKSPACE_CONF"; then
    TARGET_MODE="LAPTOP"
    MSG="Switching to LAPTOP mode (eDP-1)"
else
    TARGET_MODE="TV"
    MSG="Switching to TV mode (HDMI-A-1)"
fi

# Show on-screen notification
hyprctl notify -1 3000 "rgb(00ff99)" "$MSG"

# 2. Apply changes based on target mode
if [ "$TARGET_MODE" = "LAPTOP" ]; then
    # --- Switch to LAPTOP ---
    
    # Remove the disable rule completely from monitor.conf
    sed -i '/^monitor = eDP-1, disable$/d' "$MONITOR_CONF"
    
    # Ensure eDP-1 is enabled with its proper resolution
    sed -i -E 's/^# *monitor = eDP-1,1920x1080@60.000,0x0,1/monitor = eDP-1,1920x1080@60.000,0x0,1/' "$MONITOR_CONF"
    
    # Workspaces: move all from HDMI-A-1 back to eDP-1
    sed -i -E 's/^workspace=([0-9]+),monitor:HDMI-A-1/#workspace=\1,monitor:HDMI-A-1/' "$WORKSPACE_CONF"
    sed -i -E 's/^#workspace=([0-9]+),monitor:eDP-1/workspace=\1,monitor:eDP-1/' "$WORKSPACE_CONF"

else
    # --- Switch to TV ---
    
    # First, comment out the eDP-1 resolution rule if it's currently active
    sed -i -E 's/^monitor = eDP-1,1920x1080@60.000,0x0,1/# monitor = eDP-1,1920x1080@60.000,0x0,1/' "$MONITOR_CONF"
    
    # Add the disable rule (insert it above the eDP-1 resolution line, but only if not already there)
    if ! grep -q "^monitor = eDP-1, disable$" "$MONITOR_CONF"; then
        sed -i -E '/^#? *monitor = eDP-1,1920x1080@60.000,0x0,1/i monitor = eDP-1, disable' "$MONITOR_CONF"
    fi
    
    # Workspaces: move all from eDP-1 to HDMI-A-1
    sed -i -E 's/^workspace=([0-9]+),monitor:eDP-1/#workspace=\1,monitor:eDP-1/' "$WORKSPACE_CONF"
    sed -i -E 's/^#workspace=([0-9]+),monitor:HDMI-A-1/workspace=\1,monitor:HDMI-A-1/' "$WORKSPACE_CONF"
fi

# 3. Reload Hyprland to apply all changes immediately
hyprctl reload
