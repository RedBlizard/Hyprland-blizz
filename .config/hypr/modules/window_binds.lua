-- █▀▄▀█ Window Rules - Clean & Optimized
-- This configuration is structured for readability and maintainability
---- WINDOW BINDINGS ----
-- Translated from window_binds.conf
-- Updated for Hyprland 0.55+ Lua configuration
local mainMod = "SUPER"

---- Window Management - Kill / Exit / Fullscreen ----
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + ALT + F",   hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ALT + P",   hl.dsp.window.pseudo())

-- Master Layout (only works when layout=master)
hl.bind(mainMod .. " + CTRL + D",      hl.dsp.layout("removemaster"),                       { desc = "Remove master (master layout)" })
hl.bind(mainMod .. " + CTRL + I",      hl.dsp.layout("addmaster"),                           { desc = "Add master (master layout)" })   
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster master"),               { desc = "Swap with master" })

-- Window cycling (works in any layout).
hl.bind(mainMod .. " + J", hl.dsp.window.cycle_next(), { desc = "Cycle to next window" })

-- Dwindle Layout
hl.bind(mainMod .. " + SPACE", hl.dsp.window.pseudo(), { desc = "Toggle pseudo-tiling (dwindle)" })   

-- Group management
hl.bind(mainMod .. " + CTRL + G",      hl.dsp.group.toggle(),   { desc = "Toggle window group" })  
hl.bind(mainMod .. " + CTRL + Tab",    hl.dsp.group.next(),     { desc = "Next window in group" })

-- Window cycling
hl.bind("ALT + Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { desc = "Cycle windows (alt-tab)" })

-- Resize windows (repeating)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true, desc = "Shrink window left" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 50,  y = 0, relative = true }), { repeating = true, desc = "Grow window right" })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true, desc = "Shrink window up" })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,  y = 50, relative = true }), { repeating = true, desc = "Grow window down" })

-- Move windows
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "l" }), { desc = "Move window left" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }), { desc = "Move window right" })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "u" }), { desc = "Move window up" })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "d" }), { desc = "Move window down" })

-- Swap windows
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "l" }), { desc = "Swap window left" })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), { desc = "Swap window right" })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "u" }), { desc = "Swap window up" })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "d" }), { desc = "Swap window down" })

-- Focus movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }), { desc = "Focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }), { desc = "Focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }), { desc = "Focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }), { desc = "Focus down" })

-- Workspace navigation
hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "m+1" }), { desc = "Next workspace" })
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }), { desc = "Previous workspace" })

-- Special workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }), { desc = "Move to scratchpad" })
hl.bind(mainMod .. " + U",         hl.dsp.workspace.toggle_special(),              { desc = "Toggle scratchpad" })

-- Workspace binds (1-10) using loops
for i = 1, 9 do
  local key = tostring(i)
  hl.bind(mainMod .. " + code:" .. tostring(9 + i),              hl.dsp.focus({ workspace = i }),                      { desc = "Go to workspace " .. key })
  hl.bind(mainMod .. " + SHIFT + code:" .. tostring(9 + i),      hl.dsp.window.move({ workspace = i }),                { desc = "Move window to workspace " .. key })
  hl.bind(mainMod .. " + CTRL + code:" .. tostring(9 + i),       hl.dsp.window.move({ workspace = i, silent = true }), { desc = "Silently move to workspace " .. key })
end

hl.bind(mainMod .. " + code:19",              hl.dsp.focus({ workspace = 10 }),                      { desc = "Go to workspace 10" })
hl.bind(mainMod .. " + SHIFT + code:19",      hl.dsp.window.move({ workspace = 10 }),                { desc = "Move window to workspace 10" })
hl.bind(mainMod .. " + CTRL + code:19",       hl.dsp.window.move({ workspace = 10, silent = true }), { desc = "Silently move to workspace 10" })

-- Move to workspace with bracket keys
hl.bind(mainMod .. " + SHIFT + bracketleft",   hl.dsp.window.move({ workspace = "-1" }),               { desc = "Move window to previous workspace" })
hl.bind(mainMod .. " + SHIFT + bracketright",  hl.dsp.window.move({ workspace = "+1" }),               { desc = "Move window to next workspace" })
hl.bind(mainMod .. " + CTRL + bracketleft",    hl.dsp.window.move({ workspace = "-1", silent = true }), { desc = "Silently move window to previous workspace" })
hl.bind(mainMod .. " + CTRL + bracketright",   hl.dsp.window.move({ workspace = "+1", silent = true }), { desc = "Silently move window to next workspace" })

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { desc = "Next workspace (scroll)" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { desc = "Previous workspace (scroll)" })
hl.bind(mainMod .. " + period",     hl.dsp.focus({ workspace = "e+1" }), { desc = "Next workspace" })
hl.bind(mainMod .. " + comma",      hl.dsp.focus({ workspace = "e-1" }), { desc = "Previous workspace" })

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, desc = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "Resize window" })

---- Hyprscrolling / Layout Adjustments ----
hl.bind(mainMod .. " + CTRL + period",         hl.dsp.exec_cmd("hyprctl dispatch layoutmsg move +col"))           
hl.bind(mainMod .. " + CTRL + comma",          hl.dsp.exec_cmd("hyprctl dispatch layoutmsg swapcol l"))           
hl.bind(mainMod .. " + SHIFT + period",        hl.dsp.exec_cmd("hyprctl dispatch layoutmsg movewindowto r"))
hl.bind(mainMod .. " + SHIFT + comma",         hl.dsp.exec_cmd("hyprctl dispatch layoutmsg movewindowto l"))
hl.bind(mainMod .. " + CTRL + SHIFT + up",     hl.dsp.exec_cmd("hyprctl dispatch layoutmsg movewindowto u"))      
hl.bind(mainMod .. " + CTRL + SHIFT + down",   hl.dsp.exec_cmd("hyprctl dispatch layoutmsg movewindowto d"))
