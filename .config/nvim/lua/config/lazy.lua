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
        vim.g.barbar_auto_setup = false  -- Disable automatic setup if manual configuration is preferred
      end,
      opts = {
        animation = true,               -- Enable animation for tab transitions
        insert_at_start = false,        -- Ensure new tabs are inserted at the end (right side)
        tabpages = true,                -- Enable tab pages
        clickable = true,               -- Allow clicking on tabs to switch between them
        sidebar_filetypes = {
          NvimTree = true,              -- Open NvimTree as a sidebar tab
        },
        icons = true                    -- Enable icons for tabs
      },
      version = "^1.0.0", -- Optional: only update when a new 1.x version is released
    },

  },

  defaults = {
    lazy = false,      -- Load plugins eagerly
    version = false,   -- Always use the latest git commit
  },

  install = { colorscheme = { "tokyonight", "catppuccin" } },

  checker = { enabled = true }, -- Enable plugin update checker

  performance = {
    rtp = {
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

-- Keybindings for NvimTree (optional)
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" })
