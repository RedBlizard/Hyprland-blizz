-- debug.lua - Hyprland Blizz debug & state inspector
-- Lightweight runtime visibility tool (not a core dependency)

local M = {}

-- ─────────────────────────────
-- Basic header
-- ─────────────────────────────
local function header(title)
    print("\n==============================")
    print("  HYPR DEBUG: " .. title)
    print("==============================\n")
end

-- ─────────────────────────────
-- Dump full system state
-- ─────────────────────────────
function M.dump()
    header("FULL STATE DUMP")

    print(">> MONITORS")
    os.execute("hyprctl monitors")

    print("\n>> WORKSPACES")
    os.execute("hyprctl workspaces")

    print("\n>> ACTIVE WINDOW")
    os.execute("hyprctl activewindow")

    print("\n>> LAYOUT")
    os.execute("hyprctl getoption general:layout")
end

-- ─────────────────────────────
-- Quick status (lightweight)
-- ─────────────────────────────
function M.status()
    header("QUICK STATUS")

    print("Monitors:")
    os.execute("hyprctl monitors | grep Monitor")

    print("\nActive workspace:")
    os.execute("hyprctl activeworkspace")

    print("\nFocused window:")
    os.execute("hyprctl activewindow | grep class")
end

-- ─────────────────────────────
-- Check if key modules exist
-- ─────────────────────────────
function M.modules()
    header("MODULE CHECK")

    local modules = {
        "monitors.lua",
        "workspaces.lua",
        "animations.lua",
        "autostart.lua",
        "key_binds.lua",
        "window_rules.lua"
    }

    for _, file in ipairs(modules) do
        local path = os.getenv("HOME") .. "/.config/hypr/modules/" .. file
        local f = io.open(path, "r")

        if f then
            print("✔ " .. file)
            f:close()
        else
            print("✖ " .. file .. " (MISSING)")
        end
    end
end

-- ─────────────────────────────
-- Reload helper (safe wrapper)
-- ─────────────────────────────
function M.reload()
    header("RELOAD HYPRLAND")
    os.execute("hyprctl reload")
end

-- ─────────────────────────────
-- Detect current mode (your toggle system)
-- ─────────────────────────────
function M.mode()
    header("MONITOR MODE DETECTION")

    local f = io.popen("hyprctl monitors | grep 'HDMI-A-1'")
    local out = f:read("*a")
    f:close()

    if out and out ~= "" then
        print("Mode: TV (HDMI-A-1 active)")
    else
        print("Mode: LAPTOP (eDP-1 active or fallback)")
    end
end

return M
