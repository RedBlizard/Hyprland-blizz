-- █▀▄▀█ Layouts - Clean & Optimized
-- This configuration is structured for readability and maintainability

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

-- Grid Layout

hl.layout.register("grid", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then
            return
        end

        local cols = math.ceil(math.sqrt(n))

        for i, target in ipairs(ctx.targets) do
            target:place(ctx:grid_cell(i, cols))
        end
    end,
})
