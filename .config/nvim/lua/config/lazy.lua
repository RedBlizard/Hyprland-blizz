local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  ui = {
    border = "rounded",
  },
  spec = {
    -- Add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
    -- Add dashboard-nvim
    {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      opts = function()
        local logo = [[
     ██╗░░██╗██╗░░░██╗██████╗░██████╗░░░░░░░███╗░░██╗██╗░░░██╗██╗███╗░░░███╗
     ██║░░██║╚██╗░██╔╝██╔══██╗██╔══██╗░░░░░░████╗░██║██║░░░██║██║████╗░████║
     ███████║░╚████╔╝░██████╔╝██████╔╝█████╗██╔██╗██║╚██╗░██╔╝██║██╔████╔██║
     ██╔══██║░░╚██╔╝░░██╔═══╝░██╔══██╗╚════╝██║╚████║░╚████╔╝░██║██║╚██╔╝██║
     ██║░░██║░░░██║░░░██║░░░░░██║░░██║░░░░░░██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║
     ╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝░░░░░░╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
- RedBlizard November 2024 -
        ]]

        logo = string.rep("\n", 4) .. logo .. "\n\n"

        return {
          theme = "doom",
          hide = { statusline = false },
          config = {
            header = vim.split(logo, "\n"),
            center = {
              { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
              { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
              { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
              { action = "NvimTreeToggle", desc = " File Browser", icon = " ", key = "b" },
              { action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
              { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
              { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
              { action = "LazyExtras", desc = "Lazy Extras", icon = "  ", key = "x" },
              { action = "qa", desc = " Quit", icon = " ", key = "q" },
            },
            footer = function()
              local stats = require("lazy").stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
            end,
          },
        }
      end,
    },
    -- Add nvim-tree
    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
        require("nvim-tree").setup {
          view = {
            width = 30,
            side = "left",
          },
          renderer = {
            icons = {
              show = { file = true, folder = true, folder_arrow = true },
            },
          },
        }
      end,
    },
    -- Add barbar.nvim for tab management
    {
      "romgrk/barbar.nvim",
      dependencies = {
        "lewis6991/gitsigns.nvim",       -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons",   -- OPTIONAL: for file icons
      },
      init = function()
        vim.g.barbar_auto_setup = false
      end,
      opts = {
        animation = true,              -- Enable animation for tab transitions
        insert_at_start = true,        -- Insert new tabs at the start (optional)
        tabpages = true,               -- Enable tab pages (optional)
        clickable = true,              -- Allow clicking on tabs to switch between them
        sidebar_filetypes = {
          NvimTree = true,             -- Ensure NvimTree opens in a tab as well
        },
      },
      version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "tokyonight", "catppuccin" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Custom function to open monitors.conf in a new tab (top left)
local function open_monitors_conf_in_tab()
  vim.cmd("tabnew | edit ~/.config/hypr/monitors.conf")
end

-- Keybinding to open monitors.conf in a new tab
vim.keymap.set("n", "<leader>tm", open_monitors_conf_in_tab)

-- Keybinding for NvimTree (optional)
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")


