#!/bin/bash
# Toggle between Laptop (eDP-1) and TV (HDMI-A-1) modes
# For Hyprland with Lua configuration (.lua instead of .conf)
#
# LAPTOP mode: enables eDP-1, moves workspaces to eDP-1
# TV mode:     disables eDP-1, moves workspaces to HDMI-A-1

MONITOR_LUA="$HOME/.config/hypr/modules/monitors.lua"
WORKSPACE_LUA="$HOME/.config/hypr/modules/workspaces.lua"

# ─────────────────────────────────────────────
# 1. Determine current state
#    Active workspace 1 on HDMI-A-1 → currently in TV mode
# ─────────────────────────────────────────────
if grep -qE '^hl\.workspace_rule\(\{ workspace = 1, monitor = "HDMI-A-1"' "$WORKSPACE_LUA"; then
    TARGET_MODE="LAPTOP"
    MSG="Switching to LAPTOP mode (eDP-1)"
else
    TARGET_MODE="TV"
    MSG="Switching to TV mode (HDMI-A-1)"
fi

# Show on-screen notification
hyprctl notify -1 3000 "rgb(00ff99)" "$MSG"

# ─────────────────────────────────────────────
# 2. Apply monitor changes
# ─────────────────────────────────────────────
if [ "$TARGET_MODE" = "LAPTOP" ]; then

    # ── LAPTOP: enable eDP-1 ──────────────────

    # Remove the disabled = true line for eDP-1
    sed -i '/^hl\.monitor(\{ output = "eDP-1", disabled = true \})/d' "$MONITOR_LUA"

    # Uncomment the eDP-1 resolution line (-- hl.monitor → hl.monitor)
    sed -i -E 's|^-- (hl\.monitor\(\{ output = "eDP-1",\s+mode = "1920x1080")|\1|' "$MONITOR_LUA"

    # Comment out the HDMI-A-1 line (still connected but workspaces move to eDP-1)
    # Leave HDMI active if you want dual-screen; comment next line if not needed
    # sed -i -E 's|^(hl\.monitor\(\{ output = "HDMI-A-1",)|-- \1|' "$MONITOR_LUA"

else

    # ── TV: disable eDP-1 ────────────────────

    # Comment out the eDP-1 resolution line if it's currently active
    sed -i -E 's|^(hl\.monitor\(\{ output = "eDP-1",\s+mode = "1920x1080")|-- \1|' "$MONITOR_LUA"

    # Add the disabled = true rule for eDP-1 (only if not already there)
    if ! grep -qE '^hl\.monitor\(\{ output = "eDP-1", disabled = true \}\)' "$MONITOR_LUA"; then
        sed -i -E '/^-- hl\.monitor\(\{ output = "eDP-1",/i hl.monitor({ output = "eDP-1", disabled = true })' "$MONITOR_LUA"
    fi

fi

# ─────────────────────────────────────────────
# 3. Apply workspace changes
# ─────────────────────────────────────────────
if [ "$TARGET_MODE" = "LAPTOP" ]; then

    # ── LAPTOP: workspaces → eDP-1 ───────────

    # Comment out HDMI-A-1 workspace rules
    sed -i -E 's|^(hl\.workspace_rule\(\{ workspace = [0-9]+, monitor = "HDMI-A-1" \}\))|--\1|' "$WORKSPACE_LUA"

    # Uncomment eDP-1 workspace rules
    sed -i -E 's|^--(hl\.workspace_rule\(\{ workspace = [0-9]+, monitor = "eDP-1" \}\))|\1|' "$WORKSPACE_LUA"

else

    # ── TV: workspaces → HDMI-A-1 ────────────

    # Comment out eDP-1 workspace rules
    sed -i -E 's|^(hl\.workspace_rule\(\{ workspace = [0-9]+, monitor = "eDP-1" \}\))|--\1|' "$WORKSPACE_LUA"

    # Uncomment HDMI-A-1 workspace rules
    sed -i -E 's|^--(hl\.workspace_rule\(\{ workspace = [0-9]+, monitor = "HDMI-A-1" \}\))|\1|' "$WORKSPACE_LUA"

fi

# ─────────────────────────────────────────────
# 4. Reload Hyprland to apply all changes
# ─────────────────────────────────────────────
hyprctl reload
