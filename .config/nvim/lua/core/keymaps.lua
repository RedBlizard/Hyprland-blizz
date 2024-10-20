local function keymap(mode, lhs, rhs, opt)
	if not opt or type(opt) == "string" then
		opt = { silent = true, desc = opt }
	end
	vim.keymap.set(mode, lhs, rhs, opt)
end

-- General Things
keymap("n", "<leader>ul", "<cmd>Lazy<cr>", { noremap = true, silent = true, desc = "Lazy" })

-- New Tab
keymap("n", "te", ":tabedit<Return>", "New tab")
keymap("n", "ss", ":split<Return><C-w>w", "Split window")
keymap("n", "sv", ":vsplit<Return><C-w>w", "Vsplit window")

-- Move window
keymap("n", "<Space>", "<C-w>w", "Move to next window")
keymap("n", "sh", "<C-w>h", "Move to left window")
keymap("n", "sk", "<C-w>k", "Move to top window")
keymap("n", "sj", "<C-w>j", "Move to bottom window")
keymap("n", "sl", "<C-w>l", "Move to right window")

-- Resize window using <ctrl> arrow keys
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", "Resize window up")
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", "Resize window down")
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Resize window left")
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Resize window right")

-- Move text up and down
keymap("v", "<S-j>", ":m '>+1<cr>gv=gv", "Move line down")
keymap("v", "<S-k>", ":m '<-2<cr>gv=gv", "Move line up")

-- Better indenting
keymap("v", "<", "<gv", "Indent left")
keymap("v", ">", ">gv", "Indent right")
