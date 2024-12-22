return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "kyazdani42/nvim-web-devicons",
  config = function()
    local nvim_tree = require("nvim-tree")
    local api = require('nvim-tree.api')

    -- Setup nvim-tree with additional configuration
    nvim_tree.setup({
      view = {
        width = 30,
        relativenumber = true,
        mappings = {
          list = {
            { key = "t", action = "tabnew" }, -- Open file in a new tab
            { key = "<Tab>", action = "cd" }, -- Change root to node
            { key = "<C-e>", action = "replace_tree_buffer" }, -- Open in place
            { key = "<C-k>", action = "show_info_popup" }, -- Info
            { key = "<C-r>", action = "rename_sub" }, -- Rename: Omit Filename
            { key = "<C-t>", action = "open_tab" }, -- Open: New Tab
            { key = "<C-v>", action = "open_vertical" }, -- Open: Vertical Split
            { key = "<C-x>", action = "open_horizontal" }, -- Open: Horizontal Split
            { key = "<BS>", action = "navigate_parent_close" }, -- Close Directory
            { key = "<CR>", action = "open_edit" }, -- Open file
            { key = "pp", action = "open_preview" }, -- Open Preview
            { key = ">", action = "navigate_sibling_next" }, -- Next Sibling
            { key = "<", action = "navigate_sibling_prev" }, -- Previous Sibling
            { key = ".", action = "run_cmd" }, -- Run Command
            { key = "u", action = "change_root_to_parent" }, -- Up
            { key = "a", action = "create" }, -- Create
            { key = "bmv", action = "marks_bulk_move" }, -- Move Bookmarked
            { key = "B", action = "toggle_no_buffer_filter" }, -- Toggle No Buffer
            { key = "c", action = "copy_node" }, -- Copy
            { key = "C", action = "toggle_git_clean_filter" }, -- Toggle Git Clean
            { key = "[c", action = "navigate_git_prev" }, -- Prev Git
            { key = "]c", action = "navigate_git_next" }, -- Next Git
            { key = "d", action = "remove" }, -- Delete
            { key = "D", action = "trash" }, -- Trash
            { key = "E", action = "expand_all" }, -- Expand All
            { key = "e", action = "rename_basename" }, -- Rename: Basename
            { key = "]e", action = "navigate_diagnostics_next" }, -- Next Diagnostic
            { key = "[e", action = "navigate_diagnostics_prev" }, -- Prev Diagnostic
            { key = "F", action = "live_filter_clear" }, -- Clear Filter
            { key = "f", action = "live_filter_start" }, -- Filter
            { key = "g?", action = "toggle_help" }, -- Help
            { key = "gy", action = "copy_absolute_path" }, -- Copy Absolute Path
            { key = "H", action = "toggle_hidden_filter" }, -- Toggle Dotfiles
            { key = "I", action = "toggle_gitignore_filter" }, -- Toggle Git Ignore
            { key = "J", action = "navigate_sibling_last" }, -- Last Sibling
            { key = "K", action = "navigate_sibling_first" }, -- First Sibling
            { key = "m", action = "marks_toggle" }, -- Toggle Bookmark
            { key = "o", action = "open_edit" }, -- Open file
            { key = "O", action = "open_no_window_picker" }, -- Open: No Window Picker
            { key = "p", action = "paste" }, -- Paste
            { key = "P", action = "navigate_parent" }, -- Parent Directory
            { key = "q", action = "close" }, -- Close
            { key = "r", action = "rename" }, -- Rename
            { key = "R", action = "reload" }, -- Refresh
            { key = "s", action = "run_system" }, -- Run System
            { key = "S", action = "search_node" }, -- Search
            { key = "U", action = "toggle_custom_filter" }, -- Toggle Hidden
            { key = "W", action = "collapse_all" }, -- Collapse
            { key = "x", action = "cut" }, -- Cut
            { key = "y", action = "copy_filename" }, -- Copy Name
            { key = "Y", action = "copy_relative_path" }, -- Copy Relative Path
            { key = "<2-LeftMouse>", action = "open_edit" }, -- Open file (mouse click)
            { key = "<2-RightMouse>", action = "change_root_to_node" }, -- Change root to node (mouse click)
          },
        },
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Keep the tree open
          window_picker = {
            enable = false, -- Avoid focus conflicts
          },
        },
      },
      tab = {
        sync = {
          open = true, -- Sync tabs
          close = true,
        },
      },
    })

    -- Custom Key mappings for toggling NvimTree
    local keymap = vim.keymap

    -- Toggle the NvimTree sidebar
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

    -- Refresh the file browser
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" })

    -- Focus the NvimTree window if it's open
    keymap.set("n", "<leader>et", function()
      local tree_view = require("nvim-tree.view")
      if tree_view.is_visible() then
        vim.api.nvim_set_current_win(tree_view.get_winnr())
      else
        print("NvimTree is not open")
      end
    end, { desc = "Focus NvimTree" })

    -- Navigate tabs
    keymap.set("n", "H", ":tabprevious<CR>", { desc = "Previous Tab" })
    keymap.set("n", "L", ":tabnext<CR>", { desc = "Next Tab" })
  end,
}
