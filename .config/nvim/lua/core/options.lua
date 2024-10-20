local options = {
	clipboard = "unnamed,unnamedplus", --- Copy-paste between vim and everything else
	cmdheight = 0, --- Give more space for displaying messages
	completeopt = "menu,menuone,noselect", --- Better autocompletion
	emoji = false, --- Fix emoji display
	expandtab = true, --- Use spaces instead of tabs
	ignorecase = true, --- Needed for smartcase
	laststatus = 3, --- Have a global statusline at the bottom instead of one for each window
	mouse = "a", --- Enable mouse
	number = true, --- Shows current line number
	relativenumber = true, --- Enable relativenumber
	pumblend = 10, --- Enable transparancy for completion menu
	pumheight = 10, --- Max num of items in completion menu
	scrolloff = 8, --- Always keep space when scrolling to bottom/top edge
	shiftwidth = 2, --- Change a number of space characters inserted for indentation
	smartcase = true, --- Uses case in search
	smartindent = true, --- Makes indenting s/mart
	smarttab = true, --- Makes tabbing smarter
	splitbelow = true, --- Horizontal splits will automatically be to the bottom
	splitright = true, --- Vertical splits will automatically be to the right
	conceallevel = 1, --- Conceal text
	swapfile = false, --- Useless fuck
	tabstop = 2, --- Insert 2 spaces for a tab
	softtabstop = 2, --- Insert 2 spaces for a tab
	termguicolors = true, --- Correct terminal colors
	timeoutlen = 500, --- Faster completion
	updatetime = 100, --- Faster completion
	wildignore = { "*/node_modules/**" }, --- Don't search inside Node.js modules
	wrap = false, --- Turn off wrap
	backup = false, --- Not needed
	writebackup = false, --- Not needed
	autoindent = true, --- Good auto indent
	breakindent = true, --- Break indent
	backspace = "indent,eol,start", --- Making sure backspace works
	showmode = true, --- Shows mode
	undofile = true, --- Sets undo to file
	background = "dark", --- Sets default background to dark
	incsearch = true, --- Start searching before pressing enter
	encoding = "utf-8", --- The encoding displayed
	fileencoding = "utf-8", --- The encoding written to file
	autowrite = true, --- Auto-save before certain operations
	showmatch = true, --- Highlight matching brackets
	hlsearch = false, --- Disable search result highlighting
	title = true, --- Set window title to current file name
	backupskip = "/tmp/*,/private/tmp*", --- Skip backup for specific directories
	grepformat = "%f:%l:%c:%m", --- Format for parsing search results (File:Line:Column:Message)
	grepprg = "rg --vimgrep --no-heading --smart-case", --- Set the external grep program (ripgrep) with Vim grep options
}

local globals = {
	mapleader = " ", --- Map leader key to SPC
}

vim.opt.path:append({ "**" })

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end

--- Disable providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end
