-- █▀▄▀█ Hyprland - Clean & Optimized
-- This configuration is structured for readability and maintainability

---- HYPRLAND LUA ----

require("modules/debug")
require("modules/autostart")
require("modules/env_var")
require("modules/animations")
require("modules/key_binds")
require("modules/window_binds")
require("modules/window_rules")
require("modules/monitors")
require("modules/workspaces")
require("hyprland-gui")


-- Input + Touchpad

hl.config({
    input = {
        kb_layout          = "us",
        kb_variant         = ",qwerty",
        kb_options         = "",
        numlock_by_default = true,
        repeat_rate        = 25,
        repeat_delay       = 600,
        follow_mouse       = 1,
        sensitivity        = 0.0,
        accel_profile      = "adaptive",
        scroll_factor      = 1.0,
        natural_scroll     = true,
        focus_on_close     = 0,
        mouse_refocus      = true,

        touchpad = {
            natural_scroll          = true,
            clickfinger_behavior    = false,
            tap_and_drag            = true,
            disable_while_typing    = false,
            drag_lock               = false,
            scroll_factor           = 1.0,
            middle_button_emulation = false,
        },
    },
})

-- General

hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 10,
        border_size      = 3,

        col = {
            active_border = {
                colors = {
                    "rgb(8839EF)",
                    "rgb(7CB6F5)",
                    "rgb(FD807E)"
                },
                angle = 45
            },
            inactive_border = "0xff414868",
        },

        resize_on_border = true,
        allow_tearing    = true,
        layout           = "dwindle",
    },
})

-- Decoration

hl.config({
    decoration = {
        rounding         = 3,
        active_opacity   = 0.8,
        inactive_opacity = 0.8,
        dim_inactive     = false,
        dim_strength     = 0.25,

        shadow = {
            enabled      = true,
            range        = 5,
            render_power = 3,
            color        = "rgba(5e5c64ff)",
        },

        blur = {
            enabled  = true,
            size     = 6,
            passes   = 2,
            vibrancy = 0.9,
        },
    },
})

---- Hyprland Layouts ----

-- Dwindle Layout

hl.config({
    dwindle = {
        preserve_split = true,       
        smart_split    = false,
        smart_resizing = true,
    },
})

-- Master Layout

hl.config({
    master = {
        new_status  = "master",
        mfact       = 0.55,
        orientation = "left",
        new_on_top  = false,
    },
})

-- Misc

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        animate_manual_resizes  = false,
        initial_workspace_tracking = 1,
        on_focus_under_fullscreen = 1,
        allow_session_lock_restore = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms  = true,
    },
})
