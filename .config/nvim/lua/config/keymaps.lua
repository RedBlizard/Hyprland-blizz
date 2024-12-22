-- Move selected lines with shift+j or shift+k
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join line while keeping the cursor in the same position
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centred while scrolling up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Next and previous instance of the highlighted letter
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Better paste (prevents new paste buffer)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Fixed ctrl+c weirdness to exit from vertical select mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Delete shift+q keymap
vim.keymap.set("n", "Q", "<nop>")

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace current position word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Undotree
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)

-- Oil
vim.keymap.set("n", "<leader>e", "<cmd>lua require('oil').toggle_float()<CR>", { desc = "Oil" })

-- Twilight
vim.keymap.set("n", "<leader>tt", "<cmd>Twilight<CR>", { desc = "Toggle Twilight" })

-- Zen mode
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>he", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>h1", function()
  ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>h2", function()
  ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>h3", function()
  ui.nav_file(3)
end)
vim.keymap.set("n", "<leader>h4", function()
  ui.nav_file(4)
end)

-- Tmux window switching from Neovim
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")

-- Neovim Pet
vim.keymap.set("n", "<leader>;", function()
  require("duck").hatch("🐿️", 2)
end, {})

vim.keymap.set("n", "<leader>;;", function()
  require("duck").cook()
end, {})

-- Window Resize (Old Keymaps)
vim.keymap.set("n", "<S-h>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<S-j>", ":resize +2<CR>")
vim.keymap.set("n", "<S-k>", ":resize -2<CR>")
vim.keymap.set("n", "<S-l>", ":vertical resize -2<CR>")

-- 'jj' to Escape in Insert Mode (Old Keymaps)
vim.keymap.set("i", "jj", "<ESC>")

-- Window Movement (Old Keymaps)
vim.keymap.set("v", "<S-h>", "< gv")
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<S-l>", "> gv")

-- Custom Functions (Old Keymaps)
vim.keymap.set("n", "<leader>en", ":lua edit_nvim()<CR>")

-- Plugins (Old Keymaps)
vim.keymap.set("n", "<leader>dt", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>tt", ":TransparentToggle<CR>")

-- Telescope (Old Keymaps)
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>")
vim.keymap.set('n', '<leader>fw', ":Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>fgc', ":Telescope git_commits<CR>")
vim.keymap.set('n', '<leader>fgs', ":Telescope git_stash<CR>")
vim.keymap.set('n', '<leader>fgb', ":Telescope git_branches<CR>")
vim.keymap.set('n', '<leader>fv', ":Telescope treesitter<CR>")
vim.keymap.set('n', '<leader>fs', ":Telescope spell_suggest<CR>")
vim.keymap.set('n', '<leader>fc', ":Telescope colorscheme<CR>")

-- BufferLine (Old Keymaps)
vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>")
vim.keymap.set("n", "<leader>h", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>l", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader><S-h>", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<leader><S-l>", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>qq", ":bdelete<CR>")
