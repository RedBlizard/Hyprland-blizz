return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	lazy = true,
	keys = {
		{
			"<leader>bf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		-- format_after_save = {
		-- 	lsp_format = "fallback",
		-- },
		formatters_by_ft = {
			javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
			typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettier" },
			json = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			lua = { "stylua" },
			python = { "black" },
			c = { "clang_format" },
		},
		formatters = {
			black = {
				prepend_args = { "--fast" },
			},
		},
	},
}
