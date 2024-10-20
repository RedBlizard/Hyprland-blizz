return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
	keys = {
		{
			"\\\\",
			desc = "Find Buffers",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"sf",
			desc = "Find Browser",
			function()
				require("telescope").extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = vim.fn.expand("%:p:h"),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = true,
					initial_mode = "normal",
					layout_config = { height = 20 },
				})
			end,
		},
		{
			"<leader>/",
			desc = "Fuzzy search in current buffer",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
		},
		{
			"s/",
			desc = "Find String",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"sd",
			desc = "Find Files",
			function()
				require("telescope.builtin").find_files({
					no_ignore = false,
					hidden = true,
				})
			end,
		},
		{
			"sr",
			desc = "Find Recent Files",
			function()
				require("telescope.builtin").oldfiles()
			end,
		},
		{
			"se",
			desc = "Diagnostics",
			function()
				require("telescope.builtin").diagnostics()
			end,
		},
		{
			"sc",
			desc = "Colorscheme",
			function()
				vim.api.nvim_exec_autocmds("User", { pattern = "ColorSchemeLoad" })
				require("telescope.builtin").colorscheme()
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		local fb_actions = require("telescope").extensions.file_browser.actions

		telescope.setup({
			defaults = {
				mappings = {
					n = {
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				file_browser = {
					theme = "dropdown",
					hijack_netrw = false,
					mappings = {
						["i"] = {
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						["n"] = {
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
						},
					},
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		})

		telescope.load_extension("file_browser")
	end,
}
