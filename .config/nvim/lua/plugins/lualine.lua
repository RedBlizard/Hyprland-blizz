return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      options = {
        theme = nil, -- Disable theme to allow fully custom styling
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        icons_enabled = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
            separator = { right = "" },
            color = { fg = "#39404f", bg = "#8AADF4" },
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            separator = { right = "" },
            color = { fg = "#39404f", bg = "#EF9F76" },
          },
          {
            "diff",
            separator = { right = "" },
            color = { fg = "#39404f", bg = "#95D189" },
          },
        },
        lualine_c = {
          {
            "filename",
            separator = { right = "" },
            color = { fg = "#CDD6F4", bg = "#39404f" },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            separator = { left = "", right = "" },
            diagnostics_color = {
              error = { fg = "#39404f", bg = "#FF7F7F" }, -- Explicitly set error background color
              warn = { fg = "#39404f", bg = "#E78284" },
              info = { fg = "#39404f", bg = "#CA9EE6" },
              hint = { fg = "#39404f", bg = "#F4B8E4" },
            },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_y = {
          {
            "filetype",
            separator = { left = "" },
            color = { fg = "#CDD6F4", bg = "#39404f" },
          },
        },
        lualine_z = {
          {
            "location",
            icon = "",
            separator = { left = "" },
            color = { fg = "#39404f", bg = "#95D189" },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
