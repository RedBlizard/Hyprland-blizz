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
