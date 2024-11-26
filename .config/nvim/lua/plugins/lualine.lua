return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local icons = require("lazyvim.config").icons

    return {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { winbar = {} },
        always_divide_middle = true,
        globalstatus = true
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
            separator = { left = "", right = "" },
            color = { fg = "#1c1d21", bg = "#8CAAEE" },
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            separator = { left = "", right = "" },
            color = { fg = "#1c1d21", bg = "#85C1DC" },
          },
          {
            "diff",
            icons = { added = " ", modified = " ", removed = " " },
            separator = { left = "", right = "" },
            color = { fg = "#1c1d21", bg = "#7d83ac" },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            separator = { left = "", right = "" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            color = { fg = "#E78284", bg = "#45475A" }, -- Default red for all diagnostics
            diagnostics_color = {
              error = { fg = "#E78284", bg = "#45475A" },  -- Red for errors
              warn = { fg = "#EF9F76", bg = "#45475A" },   -- Orange for warnings
              info = { fg = "#E5C890", bg = "#45475A" },   -- Yellowish for info
              hint = { fg = "#99D1DB", bg = "#45475A" },   -- Blue for hints
            },
          },
          {
            "filename",
            path = 1, -- Show relative path
            shorting_target = 40, -- Truncate if too long
            separator = { left = "", right = "" },
            color = { fg = "#1c1d21", bg = "#99D1DB" },
          }
        },
        lualine_x = {
          {
            "filesize",
            separator = { left = "", right = "" },
            color = { fg = "#1c1d21", bg = "#FF7F7F" },
          },
          {
            "encoding",
            separator = { left = "", right = "" },
            color = { fg = "#1c1d21", bg = "#E78284" },
          },
        },
        lualine_y = {
          {
            "filetype",
            separator = { left = "", right = "" },
            icons_enabled = false,
            color = { fg = "#1c1d21", bg = "#EA999C" },
          },
        },
        lualine_z = {
          {
            "location",
            icon = "",
            separator = { left = "", right = "" },
            color = { fg = "#1c1d21", bg = "#F2D5CF" },
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
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
