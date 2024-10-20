-- Don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", {
	command = [[set formatoptions-=cro]],
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- Auto create dir when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Hijack netrw wit Neo-tree
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
	callback = function()
		local f = vim.fn.expand("%:p")
		if vim.fn.isdirectory(f) ~= 0 then
			vim.cmd("Neotree current dir=" .. f)
			vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
		end
	end,
})
