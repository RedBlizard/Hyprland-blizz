-- █▀▄▀█ Window Rules - Clean & Optimized
-- This configuration is structured for readability and maintainability

---- WINDOW RULES ----

-- Exact regex-safe matcher
local function exact_match(value)
    return ("^(%s)$"):format(
        value:gsub("([%.%+%*%?%^%$%(%)%[%]%{%}%|\\])", "\\%1")
    )
end

-- Raw regex matcher
local function regex_match(value)
    return value
end

local scripts = os.getenv("HOME") .. "/.local/bin/"

local terminal = {
    primary = "kitty",
    fallback = "alacritty"
}

local code = {
    primary = "geany",
    fallback = "code-oss"
}

local file_manager = {
    primary = "dolphin",
    fallback = "thunar"
}

local browser = {
    primary = "brave-browser",
    fallback = "helium-browser"
}

local workspaces = 10

---- ═══════════════════════════════════════
---- Workspace Assignment 
---- ═══════════════════════════════════════

---- ═══════════════════════════════════════
---- Scrolling layout For Workspace 1 
---- ═══════════════════════════════════════
hl.workspace_rule({ workspace = "1", layout = "scrolling" })

---- Workspace 1
hl.window_rule({ match = { class = exact_match("kitty") }, workspace = 1 })
hl.window_rule({ match = { class = exact_match("alacritty") }, workspace = 1 })

---- Workspace 2
hl.window_rule({ match = { class = exact_match("brave-browser") }, workspace = 2 })
hl.window_rule({ match = { class = exact_match("brave-youtube.com__-Default") }, workspace = 2 })

---- Workspace 3
hl.window_rule({ match = { class = exact_match("org.kde.dolphin") }, workspace = 3 })

---- ═══════════════════════════════════════
---- Scrolling layout For Workspace 4 
---- ═══════════════════════════════════════
hl.workspace_rule({ workspace = "4", layout = "scrolling" })

---- Workspace 4
hl.window_rule({ match = { class = exact_match("geany") }, workspace = 4 })
hl.window_rule({ match = { class = exact_match("code-oss") }, workspace = 4 })
-- hl.window_rule({ match = { class = exact_match("nvim") }, workspace = 4 })

---- Workspace 5
hl.window_rule({ match = { class = exact_match("brave-outlook.com__-Default")}, workspace = 5 })

---- Workspace 6
hl.window_rule({ match = { class = exact_match("chrome-localhost__-Default")}, workspace = 6 })

---- Workspace 7
hl.window_rule({ match = { class = exact_match("virt-manager") }, workspace = 7 })

---- Workspace 8
-- In use by select-wallpaper app see key_binds.lua

---- Workspace 9
hl.window_rule({ match = { class = exact_match("obs") }, workspace = 9 })
hl.window_rule({ match = { class = exact_match("guvcview") }, workspace = 9 })

---- ═══════════════════════════════════════
---- Grid layout For Workspace 10
---- ═══════════════════════════════════════
hl.workspace_rule({ workspace = "10", layout = "grid" })

---- Workspace 10
hl.window_rule({ match = { class = exact_match("pacseek") }, workspace = 10 })
hl.window_rule({ match = { class = exact_match("nwg-look") }, workspace = 10 })
hl.window_rule({ match = { title = exact_match("hypr-welcome") }, workspace = 10 })
hl.window_rule({ match = { title = exact_match("Choose Configuration") }, workspace = 10 })
hl.window_rule({ match = { title = exact_match("YAD Network Manager") }, workspace = 10 })
hl.window_rule({ match = { class = exact_match("btrfs-assistant") }, workspace = 10 })
hl.window_rule({ match = { class = exact_match("GParted") }, workspace = 10 })
hl.window_rule({ match = { title = exact_match("HyprMod") }, workspace = 10 })

---- ═══════
---- Opacity 
---- ═══════

hl.window_rule({ match = { class = exact_match("brave-browser") }, opacity = "0.95 0.95" })
hl.window_rule({ match = { class = exact_match("geany") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("thunar") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("file-roller") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("nwg-look") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("qt6ct") }, opacity = "0.95 0.90" })
hl.window_rule({ match = { class = exact_match("pavucontrol") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("yad") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { title = exact_match("nvim") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("code-oss") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("hypr-welcome") }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = exact_match("dolphin") }, opacity = "0.90 0.90" })

---- ═══════════════════════
---- Fullscreen / Float
---- ═══════════════════════

hl.window_rule({
    match = { title = exact_match("wlogout") },
    fullscreen = true,
    float = true
})

---- ══════════════════
---- Tiled Windows
---- ══════════════════

hl.window_rule({ match = { class = regex_match("^libreoffice.*") }, tile = true })

hl.window_rule({ match = { class = exact_match("brave-browser") }, tile = true })
hl.window_rule({ match = { class = exact_match("chromium.desktop") }, tile = true })
hl.window_rule({ match = { class = exact_match("firedragon") }, tile = true })
hl.window_rule({ match = { class = exact_match("firefox") }, tile = true })
hl.window_rule({ match = { class = exact_match("kitty") }, tile = true })
hl.window_rule({ match = { class = exact_match("timeshift-gtk") }, tile = true })
hl.window_rule({ match = { class = exact_match("sddm-conf") }, tile = true })

---- ═════════════════════
---- Floating Windows 
---- ═════════════════════

hl.window_rule({ match = { class = exact_match("Alacritty") }, float = true })
hl.window_rule({ match = { class = exact_match("kitty_floats") }, float = true })
hl.window_rule({ match = { class = exact_match("hypr-welcome") }, float = true })
hl.window_rule({ match = { class = exact_match("pavucontrol-qt") }, float = true })
hl.window_rule({ match = { class = exact_match("nm-connection-editor") }, float = true })
hl.window_rule({ match = { class = exact_match("Wofi") }, float = true })
hl.window_rule({ match = { class = exact_match("rofi") }, float = true })
hl.window_rule({ match = { class = exact_match("yad") }, float = true })

---- ═════════════════════
---- Floating by Title
---- ═════════════════════

local floating_titles = {
    "branchdialog",
    "confirmreset",
    "error",
    "file-roller",  
    "Media viewer",
    "notification",
    "splash",
    "xfce4-terminal"
}

for _, title in ipairs(floating_titles) do
    hl.window_rule({
        match = { title = exact_match(title) },
        float = true
    })
end

---- ═════════════════════
---- Centered Float 
---- ═════════════════════

local centered_titles = {
    "blueman-manager",
    "confirm",
    "download",
    "dialog",    
    "file_progress",
    "galculator",
    "konsole",
    "kitty_floats",
    "nm-connection-editor",
    "Open File",
    "pavucontrol-qt",
    "Wofi",
    "Rofi",
    "yad"
}

for _, title in ipairs(centered_titles) do
    hl.window_rule({
        match = { title = exact_match(title) },
        float = true,
        center = true
    })
end

---- ═════════════════════
---- No Animation 
---- ═════════════════════

hl.window_rule({
    match = { title = exact_match("Rofi") },
    float = true,
    no_anim = true
})

hl.window_rule({
    match = { title = exact_match("Wofi") },
    float = true,
    no_anim = true
})

---- ═════════════════════
---- Window Size 
---- ═════════════════════

hl.window_rule({
    match = { class = exact_match("Alacritty") },
    size = { 1889, 1006 }
})

hl.window_rule({
    match = { class = exact_match("kitty"), title = exact_match("kitty_floats") },
    float = true,
    size = { 800, 500 }
})


hl.window_rule({
    match = { title = exact_match("download") },
    size = { 800, 600 }
})

hl.window_rule({
    match = {
        title = regex_match("^(Open File|Save File|Volume Control)$")
    },
    size = { 800, 600 }
})

---- ═════════════════════
---- Hypr-welcome Rules 
---- ═════════════════════

-- List of all YAD window titles that should receive these rules
local welcome_titles = {
    "hypr-welcome",
    "YAD",
    "Pick your waybar",
    "Change your settings",
    "Change your configs",
    "Hyprland lua configs",
    "Waybar Configs",
    "Waybar Styles",
    "Awww"
}

-- Apply the rules to all titles in the list
for _, title in ipairs(welcome_titles) do
    hl.window_rule({
        match = { title = exact_match(title) },        
        float = true,
        pseudo = false,
        no_anim = true,
        center = true,    
        size = { 900, 425 }    
    })
end

---- ═════════════════════
---- Yad Network Manager
---- ═════════════════════

-- List of all YAD window titles that should receive these rules
local network_titles = {
    "YAD Network Manager",
    "Available Wi-Fi Networks",
    "Network Connections",
    "Editing Wired connection",
    "Editing Hypr",
    "YAD"
}

-- Apply the rules to all titles in the list
for _, title in ipairs(network_titles) do
    hl.window_rule({
        match = { title = exact_match(title) },
        match = { class = exact_match("nm-connection-editor") },
        float = true,
        pseudo = false,
        no_anim = true,
        center = true,    
        size = { 900, 425 }    
    })
end

---- ═════════════════════
---- Special Rules
---- ═════════════════════

hl.window_rule({
    match = {
        class = exact_match("brave-browser"),
        title = regex_match("^(Save File|Open File)$")
    },
    float = true
})

hl.window_rule({
    match = { class = exact_match("xdg-desktop-portal-hyprland") },
    float = true
})

hl.window_rule({
    match = {
        class = exact_match("polkit-gnome-authentication-agent-1")
    },
    float = true
})

---- ═════════════════════
---- Idle Inhibit
---- ═════════════════════

hl.window_rule({
    match = { class = exact_match("mpv") },
    idle_inhibit = "focus"
})

hl.window_rule({
    match = { class = exact_match("obs") },
    idle_inhibit = "focus"
})

hl.window_rule({
    match = { class = exact_match("brave") },
    idle_inhibit = "fullscreen"
})

---- ══════════════════════════════
---- XWayland Video Bridge
---- ══════════════════════════════

hl.window_rule({
    match = { class = exact_match("xwaylandvideobridge") },
    opacity = "0.0 override 0.0 override",
    no_anim = true,
    no_focus = true,
    no_initial_focus = true
})

---- ════════════════════════════════
---- Picture in Picture with Brave 
---- ════════════════════════════════

hl.window_rule({
    match = {
        title = regex_match("Picture in picture"),
    },

    float = true,
    pin = true,
    move = {1522, 851},
    size = "425, 265",
})

