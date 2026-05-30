#!/bin/bash
# monitor_workspaces_configurator.sh - Lua version
# One-time setup for Hyprland Lua config.
# Ensures all possible monitors & workspaces are PRE-DEFINED in .lua files,
# ready to be toggled by toggle_display.sh or monitors.sh.

MONITOR_LUA="$HOME/.config/hypr/modules/monitors.lua"
WORKSPACE_LUA="$HOME/.config/hypr/modules/workspaces.lua"

# Create directories if they don't exist
mkdir -p "$(dirname "$MONITOR_LUA")" "$(dirname "$WORKSPACE_LUA")"

echo "Running Lua configurator for the first time..."

# ───────────────────────────────
# 1. Write monitors.lua template
# ───────────────────────────────
cat > "$MONITOR_LUA" << 'EOF'
-- █▀▄▀█ MONITOR CONFIGURATION (Lua)
-- 💡 All monitors pre-defined. Toggle with -- to enable/disable.

-- Primary Laptop Display
hl.monitor({ output = "eDP-1", disabled = true })
-- hl.monitor({ output = "eDP-1",     mode = "1920x1080", position = "0x0",    scale = 1 })

-- External HDMI Display
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "1920x0", scale = 1 })

-- Other common displays (pre-defined but commented)
-- hl.monitor({ output = "DP-1",    mode = "1920x1080", position = "0x0", scale = 1 })
-- hl.monitor({ output = "DP-2",    mode = "1920x1080", position = "0x0", scale = 1 })
-- hl.monitor({ output = "DP-3",    mode = "1920x1080", position = "0x0", scale = 1 })
-- hl.monitor({ output = "Other-1", mode = "2560x1440", position = "0x0", scale = 1 })
-- hl.monitor({ output = "Other-2", mode = "3840x2160", position = "0x0", scale = 1 })
-- hl.monitor({ output = "Other-3", mode = "1280x720",  position = "0x0", scale = 1 })
-- hl.monitor({ output = "Other-4", mode = "1600x900",  position = "0x0", scale = 1 })
-- hl.monitor({ output = "Other-5", mode = "1366x768",  position = "0x0", scale = 1 })
-- hl.monitor({ output = "Virtual-1", mode = "1920x1080@60", position = "auto", scale = 1 })
EOF

# ───────────────────────────────
# 2. Write workspaces.lua template
# ───────────────────────────────
cat > "$WORKSPACE_LUA" << 'EOF'
-- █▀▄▀█ workspaces.lua - Pre-defined for eDP-1 and HDMI-A-1
-- Format: hl.workspace_rule({ workspace = N, monitor = "NAME" })

---- WORKSPACES → eDP-1 ----------
--hl.workspace_rule({ workspace = 1,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 2,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 3,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 4,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 5,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 6,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 7,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 8,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 9,  monitor = "eDP-1" })
--hl.workspace_rule({ workspace = 10, monitor = "eDP-1" })

---- WORKSPACES → HDMI ----------
hl.workspace_rule({ workspace = 1,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 2,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 3,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 4,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 5,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 6,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 7,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 8,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 9,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 10, monitor = "HDMI-A-1" })
EOF

# ───────────────────────────────
# 3. Success message
# ───────────────────────────────
echo "✅ Lua configuration files created:"
echo "   $MONITOR_LUA"
echo "   $WORKSPACE_LUA"
echo "Now ready for toggle_display.sh!"

# Exit with 0 so welcome.sh knows it succeeded and can set the flag!
exit 0
