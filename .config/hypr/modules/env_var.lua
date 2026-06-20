-- █▀▄▀█ ENVIRONMENT VARIABLES - Clean & Optimized
-- This configuration is structured for readability and maintainability

---- ENVIRONMENT VARIABLES ----

-- Hyprland Environment Variables
hl.env("HYPRLAND_TRACE", "0")
hl.env("HYPRLAND_NO_RT", "1")
hl.env("HYPRLAND_NO_SD_NOTIFY", "1")
hl.env("HYPRLAND_NO_SD_VARS", "1")
hl.env("HYPRLAND_CONFIG", "") 

-- Aquamarine Environment Variables 
hl.env("AQ_TRACE", "0")
-- hl.env("AQ_DRM_DEVICES", "") 
hl.env("AQ_MGPU_NO_EXPLICIT", "1")
hl.env("AQ_NO_MODIFIERS", "1")

-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_MENU_PREFIX", "arch-")

-- Toolkit Backend Variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("WAYLAND_DISPLAY", "wayland-0,wayland-1")
hl.env("DISPLAY", ":1")
hl.env("force_no_hyprcursor", "true")
hl.env("XCURSOR_THEME", "Qogir-white-cursors")
hl.env("XCURSOR_SIZE", "24")
-- hl.env("GTK_THEME", "Colloid-Dark-Catppuccin")
hl.env("GTK_USE_PORTAL", "1")

-- Qt specific environment variables 
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
-- hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("XDG_MENU_PREFIX", "plasma-")

-- hyprland-qt-support
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style") 

-- Application specific environment variables
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Platform specific environment variables
hl.env("OZONE_PLATFORM", "wayland,x11")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
