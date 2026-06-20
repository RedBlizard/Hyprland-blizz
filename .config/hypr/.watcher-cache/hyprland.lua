-- █▀▄▀█ Hyprland - Clean & Optimized
-- This configuration is structured for readability and maintainability

---- HYPRLAND LUA ----

require("modules/animations")
require("modules/autostart")
require("modules/debug")
require("modules/env_var")
require("modules/key_binds")
require("modules/layouts")
require("modules/monitors")
require("modules/window_binds")
require("modules/window_rules")
require("modules/workspaces")

-- Needed for hyprmod
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

-- unscale XWayland

hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Decoration

hl.config({
    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
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

-- Safe load debug module (non-blocking)
local ok, dbg = pcall(require, "modules.debug")
if not ok then
    -- Log to file instead of print to avoid blocking Hyprland startup
    local cache_dir = os.getenv("HOME") .. "/.cache/hypr"
    os.execute("mkdir -p " .. cache_dir)
    local f = io.open(cache_dir .. "/debug.log", "a")
    if f then
        f:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. "Failed to load debug module: " .. dbg .. "\n")
        f:close()
    end
end
