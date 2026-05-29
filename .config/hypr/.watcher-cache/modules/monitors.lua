-- █▀▄▀█ MONITOR CONFIGURATION
-- 💡 Tip: Hyprland only applies rules to monitors that are actually connected.
-- Comment out unused entries to keep the config clean.

-- QEMU / Virtual Monitor
-- hl.monitor({ output = "Virtual-1", mode = "1920x1080@60", position = "auto", scale = 1 })

-- Primary & External Monitor Definitions

hl.monitor({ output = "eDP-1", disabled = true })
-- hl.monitor({ output = "eDP-1", disabled = true })
hl.monitor({ output = "eDP-1", disabled = true })
-- hl.monitor({ output = "eDP-1",     mode = "1920x1080", position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "1920x0", scale = 1 })

-- Extra monitor resolutions

hl.monitor({ output = "Other-2", mode = "3840x2160@60", position = "0x0", scale = 1 })
hl.monitor({ output = "Other-3", mode = "1280x720@60",   position = "0x0", scale = 1 })
hl.monitor({ output = "Other-1", mode = "2560x1440@60", position = "0x0", scale = 1 })
hl.monitor({ output = "Other-4", mode = "1600x900@60",  position = "0x0", scale = 1 })
hl.monitor({ output = "Other-5", mode = "1366x768@60",  position = "0x0", scale = 1 })
hl.monitor({ output = "DP-2",    mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-3",    mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-1",    mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "Virtual-1", mode = "1920x1080@60", position = "auto", scale = 1 })

-- Fallback / Auto-detect (disabled by default)
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "", mode = "highrr",    position = "auto", scale = 1 })
-- hl.monitor({ output = "", mode = "highres",   position = "auto", scale = 1 })

-- Custom Scaling Setup (e.g., for HiDPI or specific displays)
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 0.85 })
-- hl.env({ name = "GDK_SCALE", value = "0.85" })

-- Rotation & Transform Reference (add `transform = X` to any monitor rule):
-- 0 = normal | 1 = 90° | 2 = 180° | 3 = 270°
-- 4 = flipped | 5 = flipped + 90° | 6 = flipped + 180° | 7 = flipped + 270°
