local M = {}

M.setup = function()
	local lspconfig = require("lspconfig")
	require("lsp-zero").extend_lspconfig()

	require("lsp-zero").on_attach(function(client, bufnr)
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, { buffer = bufnr, noremap = true, silent = true, desc = "Go To Definition" })
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, { buffer = bufnr, noremap = true, silent = true, desc = "Show Hover" })
		vim.keymap.set("n", "grn", function()
			vim.lsp.buf.rename()
		end, { buffer = bufnr, noremap = true, silent = true, desc = "Rename" })
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, { buffer = bufnr, noremap = true, silent = true, desc = "Code Action" })
		vim.keymap.set("n", "<C-j>", function()
			vim.diagnostic.goto_next()
		end, { buffer = bufnr, noremap = true, silent = true, desc = "Next Diagnostic" })
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, { buffer = bufnr, noremap = true, silent = true, desc = "Signature Help" })
	end)

	require("mason-lspconfig").setup({
		handlers = {
			require("lsp-zero").default_setup,
		},
	})

	require("mason-lspconfig").setup_handlers({
		function(server_name)
			local opts = {
				on_attach = require("plugins.lsp.handlers").on_attach,
				capabilities = require("plugins.lsp.handlers").capabilities,
			}

			local require_ok, server = pcall(require, "plugins.lsp.settings." .. server_name)
			if require_ok then
				opts = vim.tbl_deep_extend("force", server, opts)
			end

			lspconfig[server_name].setup(opts)
		end,
	})
end

return M
