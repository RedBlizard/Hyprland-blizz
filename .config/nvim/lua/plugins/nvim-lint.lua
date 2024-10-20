return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = {
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		linters_by_ft = {
			lua = { "stylua" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "flake8" },
			c = { "clangtidy" },
		},
	},
	config = function()
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
