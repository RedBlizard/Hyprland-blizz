 require("config.lazy")
 
 require('nvim-web-devicons').setup {
  -- Example: Override the icon for markdown files
  override = {
    markdown = {
      icon = "",
      color = "#ffffff",
      cterm_color = "white",
      name = "Markdown"
    },
  },
}

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("cache") .. "/undo"

vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0
  end,
})

vim.api.nvim_create_autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
    vim.opt.showtabline = 2
  end,
})


vim.cmd.colorscheme("catppuccin")

-- Function to set a random highlight color for LineNr
function SetRandomLineNrColor()
  math.randomseed(os.time())

  local colors = {
    "#b4befe", -- Lavender
    "#eba0ac", -- Maroon
    "#d2fac5", -- Green
    "#f2cdcd", -- Flamingo
    "#cba6f7", -- Mauve
    "#fcc6a7", -- Peach
    "#89b4fa", -- Blue
    "#89dceb", -- Sky
  }

  local index = math.random(#colors)
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors[index], bold = true })
end

-- Ensure the random color is selected after dashboard loads
vim.api.nvim_create_autocmd("User", {
    pattern = "DashboardLoaded",
    callback = SetRandomLineNrColor,
})

-- Setting highlights for lines above and below
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e738d", bold = false })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e738d", bold = false })

-- Create a LazyExtras command
vim.api.nvim_create_user_command("LazyExtras", function()
  vim.ui.select(
    { "Show Lazy UI", "Run Custom Script", "Toggle Plugins" },
    { prompt = "Choose an action:" },
    function(choice)
      if choice == "Show Lazy UI" then
        require("lazy").show()
      elseif choice == "Run Custom Script" then
        vim.notify("Running your custom script...", vim.log.levels.INFO)
        -- Add custom script logic here
      elseif choice == "Toggle Plugins" then
        vim.notify("Toggling plugins...", vim.log.levels.INFO)
        -- Add plugin toggling logic here
      end
    end
  )
end, { desc = "Open Lazy Extras with options" })
